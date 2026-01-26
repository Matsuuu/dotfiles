#!/bin/bash

ln -sf ~/dotfiles/.npm_completion ~/.npm_completion

ln -sf ~/dotfiles/.alacritty.toml ~/.alacritty.toml
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
