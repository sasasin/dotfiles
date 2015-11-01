#!/bin/bash -v
# 白黒クッキリ補正。ほぼ白/ほぼ黒は、潰れて謎画像になる問題がある
ls "$@" | while read f; do
    convert -linear-stretch 5%x6% "$f" "$f.tmp"
    mv "$f.tmp" "$f"
done
