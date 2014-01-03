#!/bin/sh

ls "$@" | while read f; do
    pdf2jpg.sh "$f"
    rm -f "$f"
    DIRNAME=$(basename "$f" ".pdf")
    dir2pdf.sh "$DIRNAME"
    rm -rf "$DIRNAME"
done