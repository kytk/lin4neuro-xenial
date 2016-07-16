#!/bin/bash
#Lin4Neuro making script part 1
#This script installs minimal Ubuntu with XFCE 4.12
#Prerequisite: You need to install Ubuntu mini.iso and git.

#ChangeLog
#20-May-2016: Modify for Xenial (16.04)
#30-Jan-2016: Add git and default-jdk
#26-Jan-2016: Comment the download section due to the shift to github
#20-Jan-2016: Add system-config-printer-gnome
#17-Jan-2016: Add default-jre
#15-Jan-2016: Minor changes
#14-Jan-2016: Merge Engilsh version with Japanese version.
#30-Nov-2015: Modify for English version
#25-Nov-2015: Add log function

MISC_JA=""
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
     MISC_JA="nkf unar"
     touch .lin4neuro_ja
     break
  elif [ $lang == "English" ] ; then
     touch .lin4neuro_en
     break
  elif [ $lang == "quit" ] ; then
     echo "quit."
     exit 0
  fi
done

#Installation of XFCE 4.12
LANG=C
echo "Installation of XFCE 4.12"
sudo apt-get -y install xfce4 xfce4-terminal xfce4-indicator-plugin 	\
	xfce4-power-manager-plugins lightdm lightdm-gtk-greeter 	\
	shimmer-themes network-manager-gnome xinit build-essential 	\

exit

sudo apt-get -y install \
	dkms thunar-archive-plugin file-roller gawk			\ 
	default-jre default-jdk fonts-noto				\
	system-config-printer-gnome software-properties-common		\
	plymouth-themes plymouth-label

#Installation of misc packages
echo "Installation of misc packages"
sudo apt-get -y install wajig imagemagick evince vim gedit \
	unzip zip gparted $MISC_JA

#English-dependent packages
if [ $lang == "English" ] ; then
  echo "Installation of firefox"
  sudo apt-get -y install firefox firefox-locale-en
else
#Japanese-dependent environment
  echo "Installation of fcitx and firefox"
  sudo apt-get -y install fcitx fcitx-mozc firefox firefox-locale-ja
  #Change directories to English
  LANG=C xdg-user-dirs-update --force
fi

#Remove xscreensaver
sudo apt-get -y purge xscreensaver

#Installation of Ubuntu-tweak
#echo "Installation of Ubuntu-tweak"
#sudo add-apt-repository -y ppa:tualatrix/ppa
#sudo apt-get update && sudo apt-get -y install ubuntu-tweak

echo "Part1 Finished! Please reboot and run build-l4n-part2.sh."

