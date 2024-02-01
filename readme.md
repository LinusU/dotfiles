# Linus' dotfiles

My personal dotfiles for configuring my working environment.

## Setup

Clone this repo into `~/.dotfiles`, install required packages from [Brew](https://brew.sh), and then symlink in the files.

```bash
git clone git@github.com:LinusU/dotfiles.git ~/.dotfiles
brew install bat eza fd fnm jaq macos-trash ripgrep starship
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```
