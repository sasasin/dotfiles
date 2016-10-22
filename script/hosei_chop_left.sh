#!/bin/bash -v
# 左の削り取り
mogrify -crop +50+0 "$@"
