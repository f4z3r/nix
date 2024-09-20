#!/usr/bin/env sh
#
# Install basic stuff to be able to work.
# This purposefully copies and does not link, so that the repo
# does not need to be kept once installed (since some stuff
# might be further updated anyways, such as git configuration).

# bash
cp ./bashrc ~/.bashrc

# zsh
cp ./zshrc ~/.zshrc

# tmux
mkdir -p ~/.local/share/tmux/
cp ./tmux.conf ~/.tmux.conf

# vim
mkdir -p ~/.config/vim/
cp ./vimrc ~/.vimrc

# git
cp ./gitconfig ~/.gitconfig
cp ./gitignore ~/.gitignore
