#!/bin/bash

echo Install FZF? y/n
read INSTALL_FZF

echo Install Bat? y/n
read INSTALL_BAT

echo Install node and yarn? y/n
read INSTALL_NODE_AND_YARN

echo Symlink files? y/n
read SYMLINK_FILES

if [ $INSTALL_FZF = "y" ]
then
    echo "===== Installing FZF ====="
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if [ $INSTALL_BAT = "y" ]
then
    echo "===== Installing Bat ====="
    sudo apt install bat
fi

if [ $INSTALL_NODE_AND_YARN = "y" ]
then
    ./init-node-and-yarn.sh
fi

if [ $SYMLINK_FILES  = "y" ]
then
    echo "===== Symlinking settings and rc files ====="
    mkdir ~/.vim
    ln -s "$PWD/.vimrc" ~
    ln -s "$PWD/.bashrc" ~
    ln -s "$PWD/coc-settings.json" ~/.vim/
    ln -s "$PWD/rcfiles" ~/.vim/
    ln -s "$PWD/init.vim" ~/.config/nvim/
fi


echo Finished. Remember to install the font Fantasque Sans mono. You can find it here https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete
