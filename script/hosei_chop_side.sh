#!/bin/bash -v
# 左右の削り取り
mogrify -shave 50x0 "$@"
