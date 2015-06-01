#!/bin/bash -v
ls "$@" | while read f; do
    convert -linear-stretch 5%x6% "$f" "$f.tmp"
    mv "$f.tmp" "$f"
done
