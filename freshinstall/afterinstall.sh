#!/bin/bash

## set dvorak layout
loadkeys dvorak-programmer


## Pacman Tips
## https://wiki.manjaro.org/index.php?title=Pacman_Tips
# Fasttrack your mirrorlist
pacman-mirrors -f 5
pacman -Syu

## basic programs
pacman -S git
pacman -S zathura
pacman -S octopi
pacman -S wget  yaourt
pacman -S vi vim vifm firejail zathura-pdf-mupdf zathura-djvu screenfetch
pacman -S feh

## git clones
mkdir ~/Documents/gitStuff
cd ~/Documents/gitStuff/
git clone git@github.com:daleonpz/dotfiles.git
git clone git@github.com:daleonpz/dnl_tools.git
git clone git@github.com:daleonpz/blog.git
git clone git@github.com:daleonpz/Notes.git
cd ~

