#!/bin/sh
 
find ./ -type d -depth 1 \
| while read D; do
	cd $D
	pwd
	git pull
	cd ../
done

