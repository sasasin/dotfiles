#!/bin/bash
docker run -it -d -p 9999:80 -v ~/git:/workspace/ -v ~/.ssh:/root/.ssh kdelfour/cloud9-docker

