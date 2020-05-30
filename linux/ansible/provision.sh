#!/bin/bash -v
if [ "`whoami`" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi

# ansible内ではうまく取り込めないようなので
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

ansible-galaxy install -p ./roles -f -r requirements.yml
#ansible -i localhost.inv default -m setup --connection=local
ansible-playbook -i localhost.inv localhost.yml --connection=local --diff -vv
sudo -iu $SUDO_USER /bin/bash -lc 'LANG=C xdg-user-dirs-update --force'
sudo -iu $SUDO_USER /bin/bash -lc 'gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"'
