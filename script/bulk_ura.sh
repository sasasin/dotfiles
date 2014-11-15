#!/bin/sh

ls *[13579].jpg \
| xargs -P8 -L3 hosei_ura.sh

ls *.jpg \
| xargs -P8 -L3 hosei_ura.sh
