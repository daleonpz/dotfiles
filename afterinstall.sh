#!/bin/bash

## Pacman Tips
## https://wiki.manjaro.org/index.php?title=Pacman_Tips
# Fasttrack your mirrorlist
pacman-mirrors -f 5
pacman -Syu

## basic programs
pacman -S git \
    base-devel \
    gvim \
    tmux \
    tree \
    octopi \
    zathura \
    feh

## development tools
pacman -S fzf \
        the_silver_searcher \
        astyle \
        clang \
        cppcheck \
        cscope ctags \

## Install extras
pacman -S obsidian \ # note taking
    xclip \ # clipboard copy
    bleachbit \ # system cleaner
    freecad \ # CAD
    kicad \ # electronics
    kicad-library \ # electronics library
    darktable \ # photo editor

# docker
# docker desktop
# docker scout
# 
# solaar
# 
flatpak install flathub com.github.AmatCoder.mednaffe # emulator
# pcsx2
pacman -S snes9x
# mullvad

## setup git
GIT_DIR=~/Documents/git
DOTFILES_DIR=$GIT_DIR/dotfiles
mkdir -p $GIT_DIR
cd $GIT_DIR

## update dotfiles
git clone git@github.com:daleonpz/dotfiles.git
cd dotfiles
cp .vimrc /etc/vimrc
cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore

cd $GIT_DIR
git clone git@github.com:daleonpz/dnl_tools.git
cd dnl_tools
mkdir -p ~/.scripts
cp tools/bash/* ~/.scripts

# install vim plug and cscope
curl -fLo ~/.vim/autoload/plug.vim          --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/autoload/cscope_maps.vim   --create-dirs https://cscope.sourceforge.net/cscope_maps.vim

# to install copilot
# review https://github.com/github/copilot.vim

# to install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
cd $DOTFILES_DIR
cp nix.conf ~/.config/nix/nix.conf

# Install keynav
sudo pacman -S cairo libxinerama xdotool
cd $GIT_DIR
git clone https://github.com/jordansissel/keynav.git
cd keynav
make -j$(nproc)
make install

# Install xmouseless
cd $GIT_DIR
git clone https://github.com/jbensmann/xmouseless.git
cd xmouseless
cp $DOTFILES_DIR/xmouseless_config.h config.h
make -j$(nproc)
make install

cd $DOTFILES_DIR
cp .keynavrc ~/
cp .xprofile ~/
