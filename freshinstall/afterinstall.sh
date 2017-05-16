#!/bin/bash

## set dvorak layout
sudo loadkeys dvorak-programmer

## basic programs
sudo pacman -S octopi
sudo pacman -S valgrind
yes | sudo pacman -S vim vifm firejail zathura-pdf-mupdf zathura-djvu

## git clones
mkdir ~/Documents/gitStuff
cd ~/Documents/gitStuff/
git clone git@github.com:daleonpz/dotfiles.git
git clone git@github.com:daleonpz/dnl_tools.git
git clone git@github.com:daleonpz/blog.git
cd ~


## move dotfiles 
cd ~/Documents/gitStuff/dotfiles
sh restore_dotfiles.sh
cd ~

## in firefox
# vimperator
# privacy-badger
# https Everywhere
# adblock
# adblock for youtube
# noscript
# disconnect
# self destructing cookies
# bloody vikings

