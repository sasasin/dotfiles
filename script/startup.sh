#!/bin/bash

V_NAME=`lsb_release -cs`
FS_PATH=/mnt/SolarisSMB

LANG=C xdg-user-dirs-gtk-update

apt-get install -y cifs-utils fuse-utils preload

# sasasin.net file server mount
if [ ! -e $FS_PATH ];then
    mkdir -p $FS_PATH
    chown -R sasasin:sasasin $FS_PATH
    ## deleted option "codepage=...." from ubuntu 12.10
    echo "//192.168.116.5/PUBLIC /mnt/SolarisSMB cifs username=nobody,password=,uid=sasasin,gid=sasasin,rw,file_mode=0777,dir_mode=0777,iocharset=utf8,sec=ntlm 0 0" >> /etc/fstab
    mount -a
fi
# shutdown fail, if use SMBFS.
# http://itmst.blog71.fc2.com/blog-entry-171.html
update-rc.d -f umountnfs.sh remove
update-rc.d umountnfs.sh stop 1 0 6 .

# add medibuntu repositories 
if [ -e /etc/apt/sources.list.d/medibuntu.list ];then
    rm -f /etc/apt/sources.list.d/medibuntu.list
fi
wget http://www.medibuntu.org/sources.list.d/${V_NAME}.list \
    --output-document=/etc/apt/sources.list.d/medibuntu.list
apt-get update
apt-get -y --allow-unauthenticated install medibuntu-keyring

# add ubuntu japanese team
if [ -e /etc/apt/sources.list.d/ubuntu-ja.list ];then
    rm -f /etc/apt/sources.list.d/ubuntu-ja.list
fi
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- \
    | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- \
    | sudo apt-key add -
sudo wget https://www.ubuntulinux.jp/sources.list.d/${V_NAME}.list \
    -O /etc/apt/sources.list.d/ubuntu-ja.list

# add virtualbox repository
if [ -e /etc/apt/sources.list.d/virtualbox.list ];then
    rm -f /etc/apt/sources.list.d/virtualbox.list
fi
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- \
    | sudo apt-key add -
echo "deb http://download.virtualbox.org/virtualbox/debian ${V_NAME} contrib" \
    > /etc/apt/sources.list.d/virtualbox.list

# add google chrome repositories
if [ -e /etc/apt/sources.list.d/google-chrome.list ];then
    rm -f /etc/apt/sources.list.d/google-chrome.list
fi
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | sudo apt-key add - 
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list

apt-get update -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y

echo "#####"
echo "##### install packages"
echo "#####"
cat $FS_PATH/bin/init_install.lst \
| sort -u \
| grep -Ev '^#' \
| while read f ;do
    apt-get install -y $f
done

echo "#####"
echo "##### remove packages"
echo "#####"
cat $FS_PATH/bin/init_remove.lst \
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
