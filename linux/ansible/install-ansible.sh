#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
# install ansible with dependent packages
apt-get -y install python3-pip lsb
apt-get -y install ieee-data python3-httplib2 python3-jinja2 python3-markupsafe python3-netaddr python3-selinux python3-yaml
pip3 install -U ansible

