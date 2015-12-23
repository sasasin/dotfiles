#!/bin/sh -v
mkdir $1
mv *.jpg $1
dir2pdf.sh $1
