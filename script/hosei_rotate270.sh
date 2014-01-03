#!/bin/bash -v
ls "$@" | while read f; do
    jpegtran -rotate 270 "$f" > "$f.tmp"
    mv "$f.tmp" "$f"
done
