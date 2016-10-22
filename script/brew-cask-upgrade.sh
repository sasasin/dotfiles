#!/bin/sh -v
brew update
brew upgrade --all
brew cleanup

brew cask list \
| while read c; do
	! brew cask info $c \
	| grep -qF "Not installed" || brew cask install $c; 
done

brew cask cleanup
