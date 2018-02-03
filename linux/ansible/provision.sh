#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi

ansible-galaxy install -p ./roles -f -r requirements.yml
#ansible -i localhost.inv default -m setup --connection=local
ansible-playbook -i localhost.inv localhost.yml --connection=local
sudo -iu $SUDO_USER /bin/bash -lc 'LANG=C xdg-user-dirs-gtk-update'

