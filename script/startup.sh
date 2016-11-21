#!/bin/bash -v

V_NAME=`lsb_release -cs`

LANG=C xdg-user-dirs-gtk-update

apt-get install -y cifs-utils fuse-utils preload

# add ubuntu japanese team
sudo wget https://www.ubuntulinux.jp/sources.list.d/${V_NAME}.list \
    -O /etc/apt/sources.list.d/ubuntu-ja.list
rm -f /etc/apt/sources.list.d/ubuntu-ja.list
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -

# add virtualbox repository
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- \
    | sudo apt-key add -
rm -f /etc/apt/sources.list.d/virtualbox.list
echo "deb http://download.virtualbox.org/virtualbox/debian ${V_NAME} contrib" > /etc/apt/sources.list.d/virtualbox.list

# add google chrome repositories
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list
rm -f /etc/apt/sources.list.d/google-chrome.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

apt-get update -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y

echo "#####"
echo "##### install packages"
echo "#####"
rm -f /tmp/init_install.sh
cat $HOME/script/init_install.lst \
| sort -u \
| grep -Ev '^#' \
| while read f ;do
    apt-get install -y $f
done

echo "#####"
echo "##### remove packages"
echo "#####"
rm -f /tmp/init_remove.sh
cat $HOME/script/init_remove.lst \
| sort -u \
| grep -Ev '^#' \
| while read f ;do
    apt-get remove -y $f
done


# finish
apt-get update -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y

echo "######"
echo "###### END OF SCRIPT."
echo "######"
