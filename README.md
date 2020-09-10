# My NeoVim Configuration

My personal NeoVim configuration and plugins I use

## Installation

```
mkdir -p ~/.config/
git clone git://github.com/drewdeponte/dotnvim.git ~/.config/nvim
```

## Install Plugins

Launch nvim and run the following:

```
:PlugInstall
:UpdateRemotePlugins
```

## Setup Python for NeoVim providers

```
brew install pyenv
brew install pyenv-virtualenv

pyenv install 3.8.5
pyenv virtualenv 3.8.5 neovim3

pyenv install 2.7.18
pyenv virtualenv 2.7.18 neovim2

pyenv activate neovim2
pip install neovim

pyenv activate neovim3
pip3 install neovim
```

## Setup Ruby for NeoVim providers

```
brew install rbenv

rbenv install 2.7.1
```

Add `eval "$(rbenv init -)"` to your `~/.zshrc`.

Open terminal with updated `~/.zshrc` and run the following:

```
gem install neovim
```

## Setup Prettier

```
brew install prettier
```

## Check Health

Launch nvim and run `:checkhealth` to make sure everything is good.

