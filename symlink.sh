#!/bin/bash

ln -sf ~/dotfiles/.npm_completion ~/.npm_completion

lns -sf ~/dotfiles/.alacritty.toml ~/.alacritty.toml
lns -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
