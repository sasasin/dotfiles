#!/bin/sh

mkdir ~/share
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) share ~/share

