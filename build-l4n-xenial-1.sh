#!/bin/bash
#Lin4Neuro making script part 1 for Ubuntu 16.04 (Xenial)
#This script installs minimal Ubuntu with XFCE 4.12
#Prerequisite: You need to install Ubuntu mini.iso and git.

#ChangeLog
#13-Dec-2017: add dc
#09-Dec-2017: add exfat-fuse and exfat-utils
#03-Oct-2017: add at-spi2-core for supressing gedit warning
#26-Sep-2017: add tree

#(optional) Force IPv4
#Comment out the following two lines if you need IPv6
#echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4
#echo '--inet4-only=1' >> ~/.wgetrc

LANG=C
sudo apt update; sudo apt -y upgrade

log=`date +%Y-%m-%d`-part1.log
exec &> >(tee -a "$log")

echo "Which language do you want to build? (English/Japanese)"
select lang in "English" "Japanese" "quit"
do
  if [ $REPLY = "q" ] ; then
     echo "quit."
     exit 0
  fi
  if [ -z "$lang" ] ; then
     continue
  elif [ $lang == "Japanese" ] ; then

     #Setup Neurodebian repository
     wget -O- http://neuro.debian.net/lists/xenial.jp.full | \
     sudo tee /etc/apt/sources.list.d/neurodebian.sources.list

     break
  elif [ $lang == "English" ] ; then

     #Setup Neurodebian repository
     wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | \
     sudo tee /etc/apt/sources.list.d/neurodebian.sources.list

     break
  elif [ $lang == "quit" ] ; then
     echo "quit."
     exit 0
  fi
done

#Signature for neurodebian
#sudo apt-key adv --recv-keys --keyserver \
#     hkp://pgp.mit.edu:80 0xA5D32F012649A5A9
sudo apt-key add neuro.debian.net.asc
sudo apt update

#Installation of XFCE 4.12
LANG=C
echo "Installation of XFCE 4.12"
sudo apt -y install xfce4 xfce4-terminal xfce4-indicator-plugin 	\
	xfce4-power-manager-plugins lightdm lightdm-gtk-greeter 	\
	shimmer-themes network-manager-gnome xinit build-essential 	\
	dkms thunar-archive-plugin file-roller gawk fonts-noto xdg-utils

#Installation of misc packages
echo "Installation of misc packages"
sudo apt -y install wajig imagemagick evince gedit at-spi2-core\
	unzip zip gparted byobu default-jre gnome-system-monitor \
	system-config-printer-gnome xfce4-screenshooter update-manager\
	tree exfat-fuse exfat-utils vim dc

#vim settings
cp /usr/share/vim/vimrc ~/.vimrc
sed -i -e 's/"set background=dark/set background=dark/' ~/.vimrc

#English-dependent packages
if [ $lang == "English" ] ; then
  echo "Installation of firefox"
  sudo apt -y install firefox firefox-locale-en
else
#Japanese-dependent environment
  echo "Installation of firefox and Japanese-related packages"
  sudo apt -y install fcitx fcitx-mozc fcitx-config-gtk \
              unar nkf firefox firefox-locale-ja im-config
  #Change directories to English
  LANG=C xdg-user-dirs-update --force
  im-config -n fcitx
fi

#Remove xscreensaver
sudo apt -y purge xscreensaver

echo "Part1 Finished! The system will reboot. Please run build-l4n-xenial-2.sh."

sleep 5
echo "System reboot"
sudo reboot

