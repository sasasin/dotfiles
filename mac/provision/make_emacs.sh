#!/bin/bash
# http://sakito.jp/emacs/emacs24.html

EMACS_VER=24.3

mkdir -p ~/tmp/emacs
cd ~/tmp/emacs

brew install autoconf
brew install automake
brew install gnutls
brew install libxml2

curl -O http://ftp.gnu.org/pub/gnu/emacs/emacs-${EMACS_VER}.tar.gz
svn co http://svn.sourceforge.jp/svnroot/macemacsjp/inline_patch/trunk inline_patch

tar xvfz emacs-${EMACS_VER}.tar.gz
cd emacs-${EMACS_VER}
# patch -p0 < ../inline_patch/emacs-inline.patch
./configure --with-ns --without-x --disable-ns-self-contained

make bootstrap
make install

cd nextstep
ls -alF Emacs.app

cp -r Emacs.app ~/Applications

ls -alF ~/Applications/Emacs.app

