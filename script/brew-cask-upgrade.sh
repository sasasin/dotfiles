#!/bin/sh -v
brew update
brew upgrade
brew cleanup

for c in `brew cask list`; 
do 
	! brew cask info $c \
	| grep -qF "Not installed" || brew cask install $c; 
done

brew cask cleanup
