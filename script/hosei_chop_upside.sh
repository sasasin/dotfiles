#!/bin/bash -v
# 上下の削り取り
magick mogrify -shave 0x50 "$@"
