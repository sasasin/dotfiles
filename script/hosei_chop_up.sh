#!/bin/bash -v
# 上の削り取り
mogrify -crop +0+50 "$@"
