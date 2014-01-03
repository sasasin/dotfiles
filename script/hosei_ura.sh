#!/bin/bash -v

mogrify -modulate 115 +contrast "$@"
