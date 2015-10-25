#!/bin/bash
# http://www.macobserver.com/tmo/article/directly-rip-and-convert-bluray-disks-with-handbrake

cd ~
mkdir -p ~/lib

ln -s \
/opt/homebrew-cask/Caskroom/makemkv/1.9.0/MakeMKV.app/Contents/lib/libmmbd.dylib \
~/lib/libaacs.dylib

ln -s \
/opt/homebrew-cask/Caskroom/makemkv/1.9.0/MakeMKV.app/Contents/lib/libmmbd.dylib \
~/lib/libbdplus.dylib

