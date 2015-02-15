#!/bin/sh

ls "$@" | while read f; do
    DIRNAME=$(basename "$f" ".pdf")
    echo "converting $f to $DIRNAME"
    rm -rf "$DIRNAME"
    mkdir "$DIRNAME"
    pdfimages -j "$f" "$DIRNAME"/"DIRNAME"
done