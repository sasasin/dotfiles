#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
# install ansible with dependent packages
apt-get -y install ansible python2.7 python2.7-dev python-setuptools lsb
apt-get -y install ieee-data python-httplib2 python-jinja2 python-markupsafe python-netaddr python-selinux python-yaml
easy_install pip
#pip2 install ansible
#pip2 install docker-py

easy_install3 pip
pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git
pip3 install awscli
pip3 install awsebcli

add-apt-repository -yu ppa:snwh/pulp

ansible-galaxy install -p ./roles -f -r requirements.yml
#ansible -i localhost.inv default -m setup --connection=local
ansible-playbook -i localhost.inv localhost.yml --connection=local
sudo -iu $SUDO_USER /bin/bash -lc '/usr/bin/im-config -n uim'
sudo -iu $SUDO_USER /bin/bash -lc 'LANG=C xdg-user-dirs-gtk-update'

pip3 install docker-compose
