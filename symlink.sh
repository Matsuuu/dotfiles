#!/bin/bash

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.npm_completion ~/.npm_completion
#ln -sf ~/dotfiles/.profile ~/.profile

mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
