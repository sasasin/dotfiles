#!/bin/bash

# http://qiita.com/hnakamur/items/1c27cf0df19fe57ec624
xcode-select --install

# for m1
sudo softwareupdate --install-rosetta

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update
brew upgrade --greedy
# https://qiita.com/Clpsplug/items/73244a14670957703058
brew tap homebrew/bundle

brew bundle

#cat vagrantplugins.lst \
#| xargs -L1 vagrant plugin install 

ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

# ansible hosts file for installed by homebrew
mkdir -p /usr/local/etc/ansible
echo localhost > /usr/local/etc/ansible/hosts

