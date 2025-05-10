#!/bin/bash -v
# 左右の削り取り
magick mogrify -shave 50x0 "$@"
