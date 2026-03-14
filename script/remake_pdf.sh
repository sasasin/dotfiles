#!/bin/sh

ls "$@" | while read f; do
    pdf2jpg.py "$f"
    rm -f "$f"
    DIRNAME=$(basename "$f" ".pdf")
    dir2pdf.py "$DIRNAME"
    rm -rf "$DIRNAME"
done
