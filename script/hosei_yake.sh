#!/bin/bash -v
# 紙焼け補正。
magick mogrify -channel Red -separate "$@"
