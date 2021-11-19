#!/bin/bash

echo Install FZF? y/n
read INSTALL_FZF

echo Install Bat? y/n
read INSTALL_BAT

echo Install RipGrep? y/n
read INSTALL_RIPGREP

echo Install node and yarn? y/n
read INSTALL_NODE_AND_YARN

echo Symlink files? y/n
read SYMLINK_FILES

echo Install NeoVim? y/n
read INSTALL_NEOVIM

echo Install Typescript / tsserver? y/n
read INSTALL_TYPESCRIPT

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

if [ $INSTALL_RIPGREP = "y" ]
then
    echo "===== Install RipGrep ====="
    sudo apt install ripgrep
fi

if [ $INSTALL_NODE_AND_YARN = "y" ]
then
    echo "===== Initializing nvm ==== "
    ./init-node.sh
fi

if [ $SYMLINK_FILES  = "y" ]
then
    echo "===== Symlinking settings and rc files ====="
    mkdir ~/.vim
    ln -sf "$PWD/.vimrc" ~
    ln -sf "$PWD/.bashrc" ~
    ln -sf "$PWD/.env" ~
    ln -sf "$PWD/.alacritty.yml" ~
    ln -sf "$PWD/.tmux.conf" ~
    ln -sf "$PWD/.npm_completion" ~
    ln -sf "$PWD/rcfiles" ~/.vim/
    ln -sf "$PWD/ftplugin" ~/.vim/
    mkdir -p ~/.config/nvim
    ln -sf "$PWD/init.vim" ~/.config/nvim/
fi

if [ $INSTALL_NEOVIM = "y" ]
then
    echo "===== Installing NeoVim ====="
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P ../
    chmod +x ../nvim.appimage
    sudo ln -sf "$PWD/../nvim.appimage" /usr/bin/nvim
fi

if [ $INSTALL_TYPESCRIPT = "y" ]
then
    echo "===== Installing typescript ====="
    npm install -g typescript
fi


echo ""
echo Finished. Remember to install the font Fantasque Sans mono. You can find it here https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete
