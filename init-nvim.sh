#!/bin/bash

mkdir -p ~/.config/nvim
cp nvim/init.lua ~/.config/nvim
ln -sf ~/dotfiles/nvim/lua ~/.config/nvim/lua
