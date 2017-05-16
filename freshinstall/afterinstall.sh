#!/bin/bash

## set dvorak layout
loadkeys dvorak-programmer


## Pacman Tips
## https://wiki.manjaro.org/index.php?title=Pacman_Tips
# Ranking mirrors
pacman-mirrors -g
pacman -Syy

# Fasttrack your mirrorlist
pacman-mirrors -f 5
pacman -Syy

# Optimize the database access speed
pacman-optimize && sync


## basic programs
pacman -S octopi
pacman -S valgrind
pacman -S tilda
pacman -S wget  yaourt
pacman -S vi vim vifm firejail zathura-pdf-mupdf zathura-djvu screenfetch

# Packer
# Uses some of the same commands as pacman but differs in that it checks both the official repos & AUR.
yaourt -S packer

packer -S gcal



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

