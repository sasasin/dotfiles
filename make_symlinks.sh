#!/bin/sh

#rm -f ~/.bashrc
#rm -f ~/.gitconfig
#rm -f ~/.gtk-bookmarks

#ln -s ~/git/dotfiles/.bashrc ~/.bashrc
#ln -s ~/git/dotfiles/.gitconfig ~/.gitconfig
#ln -s ~/git/dotfiles/.gtk-bookmarks ~/.gtk-bookmarks 

#ln -s ~/git/dotfiles/.emacs.d/ ~/.emacs.d
ln -s ~/src/github.com/sasasin/dotfiles/script ~/script

rm -rf ~/.config/fish
ln -s ~/src/github.com/sasasin/dotfiles/.config/fish ~/.config/fish
