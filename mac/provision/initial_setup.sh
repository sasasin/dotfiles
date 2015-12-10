#!/bin/bash

# http://qiita.com/hnakamur/items/1c27cf0df19fe57ec624
xcode-select --install

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# http://befool.co.jp/blog/jiska/farewell-brew-bundle-hello-brew-brewdler/
brew tap homebrew/brewdler
cd /usr/local/Library/Taps/homebrew/homebrew-brewdler
git remote set-url origin git@github.com:Homebrew/homebrew-brewdler.git

brew brewdle

ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

apm login
apm stars --install

# ansible hosts file for installed by homebrew
mkdir -p /usr/local/etc/ansible
echo localhost > /usr/local/etc/ansible/hosts

vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-vbox-snapshot
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-cachier
vagrant plugin install sahara
