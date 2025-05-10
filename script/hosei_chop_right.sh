#!/bin/bash -v
# 右の削り取り
magick mogrify -crop -50+0 "$@"
