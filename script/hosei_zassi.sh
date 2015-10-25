#!/bin/sh -v

ls *[13579].jpg | xargs -P6 -L6 hosei_ura.sh
ls *.jpg | xargs -P6 -L6 hosei_ura.sh
ls *.jpg | xargs -P6 -L6 hosei_ura.sh
ls *.jpg | xargs -P6 -L6 hosei_sharpen.sh
ls *.jpg | xargs -P6 -L6 hosei_quality.sh

