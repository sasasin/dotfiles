#!/bin/bash -v
# 紙焼け補正。
mogrify -channel Red -separate "$@"
