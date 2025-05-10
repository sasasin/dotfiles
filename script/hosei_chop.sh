#!/bin/bash -v
# 上下左右の削り取り
magick mogrify -shave 50x50 "$@"
