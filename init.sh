#!/bin/bash

echo "===== Installing Zenburn ====="
git clone https://github.com/jnurmine/Zenburn.git ~/.vim/Zenburn
cp -r ~/.vim/Zenburn/colors/* ~/.vim/colors/

echo "===== Symlinking settings and rc files ====="
ln -s "$PWD/.vimrc" ~
ln -s "$PWD/.bashrc" ~
ln -s "$PWD/coc-settings.json" ~/.vim/
ln -s "$PWD/rcfiles" ~/.vim/

