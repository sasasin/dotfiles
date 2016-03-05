#!/bin/bash -v
# 上下左右の削り取り
mogrify -shave 50x50 "$@"
