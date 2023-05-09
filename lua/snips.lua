local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- Make it so that dynamic snippets update as you type
  updatevents = "TextChanged, TextChangedI",

  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      }
    }
  }
}

local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

ls.add_snippets("lua", {
  parse("expand", "-- This is what was expanded!"),
  s({ trig = "ternary", snippetType = "autosnippet" }, {
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }),
})

ls.add_snippets("gitcommit", {
  s({ trig = "sic", dscr = "skip ticket ID check" }, {
    t("skip_ticket_id_check")
  }),
  s({ trig = "sct", dscr = "skip test coverage check" }, {
    t("skip_test_coverage_check")
  }),
})

-- TODO: add snippet for Riverpod consumerwidget
--
-- TODO: add snippet to get setup with flutter forge tests quickly

ls.add_snippets("dart", {
  s({ trig = "ffs", dscr = "Expands 'ffs' into Flutter Forge State class starter" },
    fmt([[
    @immutable
    class {className} extends Equatable {{
      const {constructor}();

      @override
      List<Object> get props => [];
    }}
    ]], { className = i(1, "State"), constructor = rep(1) })
  ),

  s({ trig = "ffe", dscr = "Expands 'ffe' into Flutter Forge Environment class starter" },
    fmt([[
    class {className} {{
      const {constructor}();
    }}
    ]], { className = i(1, "Environment"), constructor = rep(1) })
  ),

  s({ trig = "ffa", dscr = "Expands 'ffa' into Flutter Forge Action class starter" },
    fmt([[
    abstract class {className} implements ReducerAction {{}}
    ]], { className = i(1, "Action") })
  ),

  s({ trig = "ffr", dscr = "Expands 'ffr' into Flutter Forge Reducer starter" },
    fmt([[
    final {reducerName} = Reducer<{stateType}, {environmentType}, {actionType}>(
      (state, action) {{
        return ReducerTuple(state, []);
      }}
    );
    ]], { reducerName = i(1, "reducer"), stateType = i(2, "StateClass"), environmentType = i(3, "EnvironmentClass"), actionType = i(4, "ActionClass") })
  ),

  s({ trig = "ffw", dscr = "Expands 'ffw' into Flutter Forge Widget starter" },
    fmt([[
    class {widgetName} extends ComponentWidget<{stateType}, {environmentType}, {actionType}> {{
      {constructor}({{super.key, super.store}});

      @override
      Widget build(context, viewStore) {{
        return const Text('some text');
      }}
    }}
    ]], { widgetName = i(1, "SomeWidget"), stateType = i(2, "StateClass"), environmentType = i(3, "EnvironmentClass"), actionType = i(4, "ActionClass"), constructor = rep(1) })
  ),

  s({ trig = "ffc", dscr = "Expands 'ffc' into Flutter Forge Component starter" },
    fmt([[
    import 'package:flutter/material.dart';
    import 'package:flutter_forge/flutter_forge.dart';
    import 'package:equatable/equatable.dart';

    @immutable
    class {stateClassNamePrefix}State extends Equatable {{
      const {stateClassConstructorPrefix}State();

      @override
      List<Object> get props => [];
    }}

    class {environmentClassNamePrefix}Environment {{
      const {environmentClassConstructorPrefix}Environment();
    }}

    abstract class {actionClassNamePrefix}Action implements ReducerAction {{}}

    final {reducerName} = Reducer<{reducerStateTypePrefix}State, {reducerEnvironmentTypePrefix}Environment, {reducerActionTypePrefix}Action>(
      (state, action) {{
        return ReducerTuple(state, []);
      }}
    );

    class {widgetName} extends ComponentWidget<{widgetStateTypePrefix}State, {widgetEnvironmentTypePrefix}Environment, {widgetActionTypePrefix}Action> {{
      const {widgetConstructor}({{super.key, required super.store}});

      @override
      Widget build(context, viewStore) {{
        return Rebuilder(
          store: store,
          builder: (context, state, child) {{
            return const Text('some text');
          }}
        );
      }}
    }}
    ]], {
      widgetName = i(1, "SomeWidget"),
      widgetStateTypePrefix = rep(1),
      widgetEnvironmentTypePrefix = rep(1),
      widgetActionTypePrefix = rep(1),
      widgetConstructor = rep(1),
      stateClassNamePrefix = rep(1),
      stateClassConstructorPrefix = rep(1),
      environmentClassNamePrefix = rep(1),
      environmentClassConstructorPrefix = rep(1),
      actionClassNamePrefix = rep(1),
      reducerName = i(2, "someReducer"),
      reducerStateTypePrefix = rep(1),
      reducerEnvironmentTypePrefix = rep(1),
      reducerActionTypePrefix = rep(1),
    })
  ),

  s({ trig = "fw", dscr = "Expands 'fw' into Flutter Stateless Widget class starter" },
    fmt([[
    class {className} extends StatelessWidget {{
      const {constructor}({{super.key}});

      @override
      Widget build(BuildContext context) {{
        return const Text("some text");
      }}
    }}
    ]], { className = i(1, "SomeWidget"), constructor = rep(1) })
  ),

  s({ trig = "fsw", dscr = "Expands 'fsw' into Flutter Stateful Widget class starter" },
    fmt([[
    class {className} extends StatefulWidget {{
      const {constructor}({{super.key}});

      @override
      State<{stateStatefulWidgetType}> createState() => _{stateStatefulWidgetNamePrefix}State();
    }}

    class _{stateNamePrefix}State extends State<{stateWidgetType}> {{
      @override
      Widget build(BuildContext context) {{
        return const Text("some text");
      }}
    }}
    ]], {
      className = i(1, "SomeWidget"),
      constructor = rep(1),
      stateStatefulWidgetType = rep(1),
      stateStatefulWidgetNamePrefix = rep(1),
      stateNamePrefix = rep(1),
      stateWidgetType = rep(1),
    })
  ),

  s({ trig = "fwtf", dscr = "Expands 'fwtf' into Flutter Widget Test starter" },
    fmt([[
    import 'package:flutter/material.dart';
    import 'package:flutter_test/flutter_test.dart';

    void main() {{
      testWidgets('{testSummary}', (WidgetTester tester) async {{
        await tester.pumpWidget(MaterialApp(home: {widgetInstance}));
      }});
    }}
    ]], { testSummary = i(1, "test summary"), widgetInstance = i(2, "SomeWidget()") })
  ),

  s({ trig = "fwt", dscr = "Expands 'fwt' into Flutter Widget Test starter" },
    fmt([[
    testWidgets('{testSummary}', (WidgetTester tester) async {{
      await tester.pumpWidget(MaterialApp(home: {widgetInstance}));
    }});
    ]], { testSummary = i(1, "test summary"), widgetInstance = i(2, "SomeWidget()") })
  ),

  s({ trig = "ftf", dscr = "Expands 'ftf' into Flutter Test file starter" },
    fmt([[
    import 'package:flutter_test/flutter_test.dart';

    void main() {{
      group('{groupDesc}', () {{
        test('{testSummary}', () async {{
          {testBody}
        }});
      }});
    }}
    ]], { groupDesc = i(1, "group desc"), testSummary = i(2, "test summary"), testBody = i(0) })
  ),

  s({ trig = "ft", dscr = "Expands 'ft' into Flutter Test starter" },
    fmt([[
    group('{groupDesc}', () {{
      test('{testSummary}', () async {{
        {testBody}
      }});
    }});
    ]], { groupDesc = i(1, "group desc"), testSummary = i(2, "test summary"), testBody = i(0) })
  ),

  s({ trig = "fsbs", dscr = "Expands 'fsbs' into Flutter Story Book Story starter" },
    fmt([[
    Story(
      name: '{storyName}',
      description: '{storyDescription}',
      builder: (context) {{
        {builderBody}
      }},
    ),
    ]], { storyName = i(1, "name"), storyDescription = i(2, "description"), builderBody = i(0) })
  ),
})

-- next thing in snippet or expand snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

-- prev thing in snippet or expand snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable( -1) then
    ls.jump( -1)
  end
end, { silent = true })

-- selecting within a list of options
vim.keymap.set({ "i" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- shortcut to reload snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/snips.lua<CR>")
