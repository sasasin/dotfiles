#!/bin/bash

# http://qiita.com/hnakamur/items/1c27cf0df19fe57ec624
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# homebrew-cask
brew install caskroom/cask/brew-cask

# homebrew-versions
brew tap caskroom/versions

# ansible
brew install python
brew install ansible

## homebrew, cask, atom packages for ansible
#mkdir ~/ansible-works
#cd ~/ansible-works
#ansible-galaxy install --roles-path=. hnakamur.homebrew-packages
#ansible-galaxy install --roles-path=. hnakamur.homebrew-cask-packages
#ansible-galaxy install --roles-path=. hnakamur.atom-packages 

# ansible hosts file for installed by homebrew
mkdir -p /usr/local/etc/ansible
echo localhost > /usr/local/etc/ansible/hosts

# minimum install 
brew cask install google-chrome
brew cask install google-japanese-ime

