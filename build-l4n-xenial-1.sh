#!/bin/bash
#Lin4Neuro making script for Ubuntu 16.04 (Xenial)
#This script installs minimal Ubuntu with XFCE 4.12
#and Lin4Neuro theme.
#Prerequisite: You need to install Ubuntu mini.iso and git beforehand.
#Kiyotaka Nemoto 15-Apr-2018

#ChangeLog
#15-Apr-2018 move update LibreOffice and VirtualBox related settings to part2
#15-Apr-2018 change to use the latest kernel (hwe-16.04-edge)
#07-Apr-2018 add linux-headers
#07-Apr-2018 add lines to /etc/fstab related to virtualbox shared folder
#30-Mar-2018 simplify customization of xfce
#28-Mar-2018 add libreoffice
#20-Mar-2018 add curl
#18-Mar-2018 Renew scripts

#(optional) Force IPv4
#Uncomment the following two lines if you want the system to use only IPv4
#echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4
#echo '--inet4-only=1' >> ~/.wgetrc

LANG=C
sudo apt-get update; sudo apt-get -y upgrade

log=`date +%Y%m%d%H%M%S`-part1.log
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

     #Setup Neurodebian repository using repo in Japan
     wget -O- http://neuro.debian.net/lists/xenial.jp.full | \
     sudo tee /etc/apt/sources.list.d/neurodebian.sources.list

     break
  elif [ $lang == "English" ] ; then

     #Setup Neurodebian repository using in repo in us-nh
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

#Installation of XFCE 4.12
LANG=C
echo "Installation of XFCE 4.12"
sudo apt-get -y install xfce4 xfce4-terminal xfce4-indicator-plugin 	\
	xfce4-power-manager-plugins lightdm lightdm-gtk-greeter 	\
	shimmer-themes network-manager-gnome xinit build-essential 	\
	dkms thunar-archive-plugin file-roller gawk fonts-noto xdg-utils

#Installation of misc packages
echo "Installation of misc packages"

sudo apt-get -y install at-spi2-core bc byobu curl dc 		\
	default-jre evince exfat-fuse exfat-utils gedit 	\
	gnome-system-monitor gnome-system-tools gparted		\
	imagemagick nemo ntp system-config-printer-gnome 	\
	system-config-samba tree unzip update-manager vim 	\
	wajig xfce4-screenshooter zip 

#Install the latest kernel
sudo apt-get -y install linux-image-generic-hwe-16.04-edge

#Workaround for system-config-samba
sudo touch /etc/libuser.conf

#vim settings
cp /usr/share/vim/vimrc ~/.vimrc
sed -i -e 's/"set background=dark/set background=dark/' ~/.vimrc

#Install firefox and libreoffice with language locale
if [ $lang == "English" ] ; then
  #English-dependent packages
  echo "Installation of firefox"
  sudo apt-get -y install firefox firefox-locale-en
  echo "Installation of libreoffice"
  sudo apt-get -y install libreoffice libreoffice-help-en

else
  #Japanese-dependent environment
  echo "Installation of firefox and Japanese-related packages"
  sudo apt-get -y install fcitx fcitx-mozc fcitx-config-gtk 	\
              unar nkf firefox firefox-locale-ja im-config
  echo "Installation of libreoffice"
  sudo apt-get -y install libreoffice libreoffice-l10n-ja \
	libreoffice-help-ja

  #Change directories to English
  LANG=C xdg-user-dirs-update --force
  im-config -n fcitx
fi

#Remove xscreensaver
sudo apt-get -y purge xscreensaver

#Installation of Lin4Neuro related settings

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#Install plymouth-related files
sudo apt-get -y install plymouth-themes plymouth-label

#Installation of lin4neuro-logo
echo "Installation of lin4neuro-logo"
sudo cp -r ${base_path}/lin4neuro-logo /usr/share/plymouth/themes
sudo update-alternatives --install 					\
	/usr/share/plymouth/themes/default.plymouth 			\
	default.plymouth 						\
	/usr/share/plymouth/themes/lin4neuro-logo/lin4neuro-logo.plymouth \
	100
sudo update-initramfs -u -k all

#Installation of icons
echo "Installation of icons"
mkdir -p ~/.local/share
cp -r ${base_path}/local/share/icons ~/.local/share/

#Installation of customized menu
echo "Installation of customized menu"
mkdir -p ~/.config/menus
cp ${base_path}/config/menus/xfce-applications.menu \
	~/.config/menus

#Installation of .desktop files
echo "Installation of .desktop files"
cp -r ${base_path}/local/share/applications ~/.local/share/

#Installation of Neuroimaging.directory
echo "Installation of Neuroimaging.directory"
mkdir -p ~/.local/share/desktop-directories
cp ${base_path}/local/share/desktop-directories/Neuroimaging.directory ~/.local/share/desktop-directories

#Copy background image
echo "Copy background image"
sudo cp ${base_path}/backgrounds/deep_ocean.png /usr/share/backgrounds

#Remove an unnecessary image file
sudo rm /usr/share/backgrounds/xfce/xfce-teal.jpg

#Copy modified lightdm-gtk-greeter.conf
echo "Copy modified 01_ubuntu.conf"
sudo mkdir -p /usr/share/lightdm/lightdm-gtk-greeter.conf.d
sudo cp ${base_path}/lightdm/lightdm-gtk-greeter.conf.d/01_ubuntu.conf /usr/share/lightdm/lightdm-gtk-greeter.conf.d

#Settings for auto-login
echo "Settings for auto-login"
sudo mkdir -p /usr/share/lightdm/lightdm.conf.d
sudo cp ${base_path}/lightdm/lightdm.conf.d/10-ubuntu.conf \
	/usr/share/lightdm/lightdm.conf.d

#Cusotmize of panel, dsktop, and theme
echo "Cusotmize of panel, dsktop, and theme"

cp -r ${base_path}/config/xfce4 ~/.config

#Clean packages
sudo apt-get -y autoremove

#GRUB setting for plymouth
echo '' | sudo tee -a /etc/default/grub
echo '#GRUB setting for plymouth' | sudo tee -a /etc/default/grub
echo 'GRUB_GFXPAYLOAD_LINUX="auto"' | sudo tee -a /etc/default/grub 
sudo sh -c 'echo 'FRAMEBUFFER=y' > /etc/initramfs-tools/conf.d/splash'
sudo update-grub

#(Optional)Display GRUB menu
#comment out following two lines if you don't want to show GRUB menu
#sudo sed -i -e 's/GRUB_HIDDEN_TIMEOUT/#GRUB_HIDDEN_TIMEOUT/' /etc/default/grub
#sudo update-grub

echo "Finished! The system will reboot in 10 seconds."
echo "Please run build-l4n-xenial-2.sh to install neuroimaging packages."
echo "Reboot system in 5 seconds"
sleep 5
sudo reboot

