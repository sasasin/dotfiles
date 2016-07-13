#!/bin/bash -v
# 上下の削り取り
mogrify -shave 0x50 "$@"
