#!/bin/bash -v
pdfindex.awk a.txt > b.txt
cat b.txt
jpdfbookmarks_cli -f -a b.txt "$1"
