#!/bin/bash
#Lin4Neuro making script part 4
#Remastersys

#ChangeLog
#07-Jan-2017: Modify for L4N-16.04
#26-Jan-2016: Comment downloading remastersys
#17-Jan-2016: Merge Japanese and English version.
#28-Nov-2015: Update version of remastersys

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#Installation of required packages for Remastersys
sudo apt-get -y install isolinux casper genisoimage squashfs-tools \
     syslinux-utils

#Installation of Remastersys
sudo cp -r ${base_path}/remastersys/etc/* /etc
sudo cp ${base_path}/remastersys/remastersys /usr/bin
sudo chmod 755 /usr/bin/remastersys

if [ `echo $LANG` = ja_JP.UTF-8 ]; then
    sudo mv /etc/remastersys.conf.ja /etc/remastersys.conf
else
    sudo mv /etc/remastersys.conf.en /etc/remastersys.conf
fi

#usb-creator
sudo apt-get -y install usb-creator-common usb-creator-gtk

echo "Part 4 finished! Now ready for remastering. Execute l4n_remastering.sh"
