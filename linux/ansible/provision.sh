#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
# install ansible with dependent packages
apt-get -y install python2.7 python-setuptools lsb
apt-get -y ieee-data python-httplib2 python-jinja2 python-markupsafe python-netaddr python-selinux python-yaml
pip install ansible
pip install docker-py

ansible-galaxy install -p ./roles -f -r requirements.yml
#ansible -i localhost.inv default -m setup --connection=local
ansible-playbook -i localhost.inv localhost.yml --connection=local
sudo -iu $SUDO_USER /bin/bash -lc '/usr/bin/im-config -n fcitx'
sudo -iu $SUDO_USER /bin/bash -lc 'LANG=C xdg-user-dirs-gtk-update'
