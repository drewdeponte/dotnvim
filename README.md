# My NeoVim Configuration

My personal NeoVim configuration and plugins I use

## Installation

```
mkdir -p ~/.config/
git clone https://github.com/drewdeponte/dotnvim.git ~/.config/nvim
```

## Structure

My configuration is split up into the three sections.

1. `init.lua` - this is the main entry-point for initializing [folke/lazy.nvim][] as
   well as general preferences
2. `lua/plugins/*.lua` - these are all plugin specs for loading and configuring
   plugins using [folke/lazy.nvim][]
3. `lua/*.lua` - these are personal plugins that I whipped up but never
   released as separate plugins

I chose to use [folke/lazy.nvim][] because it allows for lazy loading of
plugins which makes startup time quicker. It also lets you specify dependency
relationships of plugins to control the order in which plugins are loaded.

## Check Health

Launch `nvim` and run `:checkhealth` to make sure everything you care about is
good.

[folke/lazy.nvim]: https://github.com/folke/lazy.nvim
