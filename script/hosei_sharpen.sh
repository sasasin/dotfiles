#!/bin/sh -v

mogrify -sharpen 4x4 "$@"
