

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

