#!/bin/bash

## Pacman Tips
## https://wiki.manjaro.org/index.php?title=Pacman_Tips
# Fasttrack your mirrorlist
pacman-mirrors -f 5
pacman -Syu

## basic programs
pacman -S git
pacman -S base-devel
pacman -S gvim
pacman -S tmux
pacman -S cscope ctags
pacman -S tree
pacman -S octopi
pacman -S zathura
pacman -S feh

## development tools
pacman -S fzf \
        the_silver_searcher \
        astyle \
        clang \
        cppcheck \

mkdir ~/Documents/git
cd ~/Documents/git/
## git clones
git clone git@github.com:daleonpz/dotfiles.git
cd dotfiles
cp .vimrc /etc/vimrc
cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf

git clone git@github.com:daleonpz/dnl_tools.git
mkdir -p ~/.scripts
cd dnl_tools
cp tools/bash/* ~/.scripts


## Install
pacman -S obsidian \
    xclip \ # clipboard copy
    bleachbit \ # system cleaner
    freecad \ # CAD
    kicad \ # electronics
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

# install vim plug and cscope
curl -fLo ~/.vim/autoload/plug.vim          --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/autoload/cscope_maps.vim   --create-dirs https://cscope.sourceforge.net/cscope_maps.vim

# to install copilot
# review https://github.com/github/copilot.vim

# to install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
cp nix.conf ~/.config/nix

# Install keynav
sudo pacman -S cairo libxinerama xdotool
git clone https://github.com/jordansissel/keynav.git ~/Documents/git/keynav
cd ~/Documents/git/keynav
make -j$(nproc)
make install
cd -

cp .keynavrc ~/
cp .xprofile ~/

git clone https://github.com/jbensmann/xmouseless.git ~/Documents/git/xmouseless
cp xmouseless_config.h ~/Documents/git/xmouseless/config.h
cd ~/Documents/git/xmouseless/ 
make -j$(nproc)
make install
cd -
