#!/bin/sh -v

mkdir $1
sleep 2
mv *.jpg $1
cd $1
ads2500w_rename.sh *.jpg > /dev/null 2>&1
cd ../

dir2pdf.sh $1
