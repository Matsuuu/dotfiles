#!/bin/bash

echo Install FZF? y/n
read INSTALL_FZF

echo Install Bat? y/n
read INSTALL_BAT

echo Install node and yarn? y/n
read INSTALL_NODE_AND_YARN

echo Install miramare? y/n
read INSTALL_MIRAMARE

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
    echo "===== Initializing nvm ==== "
    ./init-node.sh
fi

if [ $INSTALL_MIRAMARE = "y" ]
then
    git clone https://github.com/franbach/miramare.git ~/miramare
    mkdir -p ~/.vim/colors/
    mkdir -p ~/.vim/autoload/airline/themes
    cp ~/miramare/colors/miramare.vim ~/.vim/colors/miramare.vim
    cp ~/miramare/autoload/airline/themes/miramare.vim ~/.vim/autoload/airline/themes/miramare.vim
fi

if [ $SYMLINK_FILES  = "y" ]
then
    echo "===== Symlinking settings and rc files ====="
    mkdir ~/.vim
    ln -sf "$PWD/.vimrc" ~
    ln -sf "$PWD/.bashrc" ~
    ln -sf "$PWD/.alacritty.yml" ~
    ln -sf "$PWD/rcfiles" ~/.vim/
    mkdir ~/.config/nvim
    ln -sf "$PWD/init.vim" ~/.config/nvim/
fi


echo Finished. Remember to install the font Fantasque Sans mono. You can find it here https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete
