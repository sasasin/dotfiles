#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
# install ansible with dependent packages
apt-get -y install ansible python2.7 python2.7-dev python-setuptools lsb
apt-get -y install ieee-data python-httplib2 python-jinja2 python-markupsafe python-netaddr python-selinux python-yaml
easy_install pip
pip2 install -U ansible

