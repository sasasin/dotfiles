#!/bin/bash -v
ls "$@" | while read f; do
    convert -linear-stretch 10%x11% "$f" "$f.tmp"
    mv "$f.tmp" "$f"
done
