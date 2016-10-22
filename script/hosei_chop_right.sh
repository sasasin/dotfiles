#!/bin/bash -v
# 右の削り取り
mogrify -crop -50+0 "$@"
