#!/bin/bash

#Lin4Neuro making script for Ubuntu 16.04 (Xenial)
#This script installs minimal Ubuntu with XFCE 4.12
#and Lin4Neuro theme.
#Prerequisite: You need to install Ubuntu mini.iso and git beforehand.
<<<<<<< HEAD
#Kiyotaka Nemoto 12-Mar-2019

#ChangeLog
#12-Mar-2019 Harmonize with build-l4n-bionic-1.sh
=======
#Kiyotaka Nemoto 15-Sep-2018

#ChangeLog
#15-Sep-2018 add xterm and bleachbit
>>>>>>> 51d14308607d4c7eab4585e1de8c20d095fe3e12
#28-Jul-2018 add ntp
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

log=$(date +%Y%m%d%H%M%S)-part1.log
exec &> >(tee -a "$log")

echo "Begin making Lin4Neuro."
echo "Do you want to install virtualbox-guest? (Yes/No)"
select vbguest in "Yes" "No" "quit"
do
  if [ "$REPLY" = "q" ] ; then
    echo "quit."
    exit 0
  fi
  if [ -z "$vbguest" ] ; then
    continue
  elif [ $vbguest == "Yes" ] ; then
    echo "VirtualBox guest will be installed later."
    vbinstall=1
    break
  elif [ $vbguest == "No" ] ; then
    echo "VirtualBox guest will not be installed."
    vbinstall=0
    break
  elif [ $vbguest == "quit" ] ; then
    echo "quit."
    exit 0
  fi
done

echo "Which language do you want to build? (English/Japanese)"
select lang in "English" "Japanese" "quit"
do
  if [ "$REPLY" = "q" ] ; then
     echo "quit."
     exit 0
  fi
  if [ -z "$lang" ] ; then
     continue
  elif [ $lang == "Japanese" ] ; then

     #Setup Japanese locale
     sudo apt-get install -y language-pack-ja manpages-ja
     sudo update-locale LANG=ja_JP.UTF-8

     #Setup tzdata
     sudo dpkg-reconfigure tzdata

     #replace us with ja in  /etc/apt/sources.list
     sudo sed -i 's|http://us.|http://ja.|g' /etc/apt/sources.list
     sudo apt-get update

     #Setup Neurodebian repository using repo in Japan
     wget -O- http://neuro.debian.net/lists/xenial.jp.full | \
     sudo tee /etc/apt/sources.list.d/neurodebian.sources.list

     break
  elif [ $lang == "English" ] ; then

     #Setup tzdata
     sudo dpkg-reconfigure tzdata

     #Setup Neurodebian repository using in repo in us-nh
     wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | \
     sudo tee /etc/apt/sources.list.d/neurodebian.sources.list

     break
  elif [ $lang == "quit" ] ; then
     echo "quit."
     exit 0
  fi
done

#Install linux-{image,headers}-generic-hwe-16.04
sudo apt-get -y install linux-{image,headers}-generic-hwe-16.04

#Signature for neurodebian
sudo apt-key add neuro.debian.net.asc
#Alternative way 1
#sudo apt-key adv --recv-keys --keyserver \
#     hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
#Alternative way 2
#gpg --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys 0xA5D32F012649A5A9
#gpg -a --export 0xA5D32F012649A5A9 | sudo apt-key add -

#Installation of XFCE 4.12
echo "Installation of XFCE 4.12"
sudo apt-get -y install xfce4 xfce4-terminal xfce4-indicator-plugin 	\
	xfce4-power-manager-plugins lightdm lightdm-gtk-greeter 	\
	shimmer-themes network-manager-gnome xinit build-essential 	\
	dkms thunar-archive-plugin file-roller gawk fonts-noto 		\
	xdg-utils 

#Installation of python-related packages
sudo apt-get -y install build-essential pkg-config              \
        libopenblas-dev liblapack-dev libhdf5-serial-dev graphviz 
sudo apt-get -y install python3-venv python3-pip python3-dev    \
        python3-tk      


#Installation of misc packages
echo "Installation of misc packages"

sudo apt-get -y install at-spi2-core bc byobu curl dc 		\
	default-jre evince exfat-fuse exfat-utils gedit 	\
	gnome-system-monitor gnome-system-tools gparted		\
	imagemagick nemo ntp system-config-printer-gnome 	\
	system-config-samba tree unzip update-manager vim 	\
<<<<<<< HEAD
	wajig xfce4-screenshooter zip ntp tcsh baobab xterm     \
        bleachbit libopenblas-base cups apturl dmz-cursor-theme

=======
	wajig xfce4-screenshooter zip ntp xterm bleachbit
>>>>>>> 51d14308607d4c7eab4585e1de8c20d095fe3e12


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

elif [ $lang == "Japanese" ] ; then
  #Japanese-dependent environment
  echo "Installation of firefox and Japanese-related packages"
  sudo apt-get -y install fcitx fcitx-mozc fcitx-config-gtk 	\
              unar nkf firefox firefox-locale-ja im-config
  echo "Installation of libreoffice"
  sudo apt-get -y install libreoffice libreoffice-l10n-ja \
	libreoffice-help-ja

  #Change name of directories to English
  LANG=C xdg-user-dirs-update --force
  im-config -n fcitx
fi

#Remove xscreensaver
sudo apt-get -y purge xscreensaver

#Installation of Lin4Neuro related settings

#Setting of path of the setting scripts
currentdir=$(cd $(dirname "$0") && pwd)
base_path=$currentdir/lin4neuro-parts

#Install plymouth-related files
sudo apt-get -y install plymouth-themes plymouth-label

#Installation of lin4neuro-logo
echo "Installation of lin4neuro-logo"
sudo cp -r "${base_path}"/lin4neuro-logo /usr/share/plymouth/themes
sudo update-alternatives --install 					\
	/usr/share/plymouth/themes/default.plymouth 			\
	default.plymouth 						\
	/usr/share/plymouth/themes/lin4neuro-logo/lin4neuro-logo.plymouth \
	100
sudo update-initramfs -u -k all

#Installation of icons
echo "Installation of icons"
mkdir -p ~/.local/share
cp -r "${base_path}"/local/share/icons ~/.local/share/

#Installation of customized menu
echo "Installation of customized menu"
mkdir -p ~/.config/menus
cp "${base_path}"/config/menus/xfce-applications.menu \
	~/.config/menus

#Installation of .desktop files
echo "Installation of .desktop files"
cp -r "${base_path}"/local/share/applications ~/.local/share/

#Installation of Neuroimaging.directory
echo "Installation of Neuroimaging.directory"
mkdir -p ~/.local/share/desktop-directories
cp "${base_path}"/local/share/desktop-directories/Neuroimaging.directory ~/.local/share/desktop-directories

#Copy background image
echo "Copy background image"
sudo cp "${base_path}"/backgrounds/deep_ocean.png /usr/share/backgrounds

#Remove an unnecessary image file
sudo rm /usr/share/backgrounds/xfce/xfce-teal.jpg

#Copy modified lightdm-gtk-greeter.conf
echo "Copy modified 01_ubuntu.conf"
sudo mkdir -p /usr/share/lightdm/lightdm-gtk-greeter.conf.d
sudo cp "${base_path}"/lightdm/lightdm-gtk-greeter.conf.d/01_ubuntu.conf /usr/share/lightdm/lightdm-gtk-greeter.conf.d

#Settings for auto-login
echo "Settings for auto-login"
sudo mkdir -p /usr/share/lightdm/lightdm.conf.d
sudo cp "${base_path}"/lightdm/lightdm.conf.d/10-ubuntu.conf \
	/usr/share/lightdm/lightdm.conf.d

#Cusotmize of panel, dsktop, and theme
echo "Cusotmize of panel, dsktop, and theme"

cp -r "${base_path}"/config/xfce4 ~/.config

#Clean packages
sudo apt-get -y autoremove

#GRUB setting for plymouth
#echo '' | sudo tee -a /etc/default/grub
#echo '#GRUB setting for plymouth' | sudo tee -a /etc/default/grub
#echo 'GRUB_GFXPAYLOAD_LINUX="auto"' | sudo tee -a /etc/default/grub 
#sudo sh -c 'echo 'FRAMEBUFFER=y' > /etc/initramfs-tools/conf.d/splash'
#sudo update-grub

#(Optional)Display GRUB menu
#uncomment the following two lines if you don't want to show GRUB menu
#sudo sed -i -e 's/GRUB_HIDDEN_TIMEOUT/#GRUB_HIDDEN_TIMEOUT/' /etc/default/grub
#sudo update-grub

#alias
cat << EOS >> ~/.bashrc

#alias for xdg-open
alias open='xdg-open &> /dev/null'

EOS

#VirtualBox guest related settings
if [ $vbinstall -eq 1 ]; then
#    echo "Install the kernel header"
#    sudo apt-get -y install linux-headers-$(uname -a | awk '{ print $3 }')

    echo "Install virtualbox guest"
#    sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-x11
    sudo usermod -aG vboxsf '$(whoami)'

    #fstab
    echo '' | sudo tee -a /etc/fstab
    echo '#Virtualbox shared folder' | sudo tee -a /etc/fstab
    echo 'share /media/sf_share vboxsf _netdev,uid=1000,gid=1000 0 0' | sudo tee -a /etc/fstab
fi

echo "Finished! The system will reboot in 10 seconds."
echo "Please run build-l4n-xenial-2.sh to install neuroimaging packages."
echo "Reboot system in 5 seconds"
sleep 5
sudo reboot

