#!/bin/bash

# http://qiita.com/hnakamur/items/1c27cf0df19fe57ec624
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
brew tap caskroom/cask

#brew brewdle

cat brewfile.lst \
| xargs -L1 brew install

cat brewcaskfile.lst \
| xargs -L1 brew cask install

cat vagrantplugins.lst \
| xargs -L1 vagrant plugin install 

ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

apm login
apm stars --install

# ansible hosts file for installed by homebrew
mkdir -p /usr/local/etc/ansible
echo localhost > /usr/local/etc/ansible/hosts

