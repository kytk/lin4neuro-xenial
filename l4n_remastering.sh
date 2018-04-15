#!/bin/bash
#Remastering with Remastersys for Lin4Neuro 16.04
#31-Mar-2018 K. Nemoto

#Execute as a normal user!

#Check the script is run by a normal user
if [ "$(whoami)" = "root" ]; then
	echo "Run with normal user. Exiting."
	exit 1
fi

#Log
log=`date +%Y%m%d%H%M%S`-remastersys.log
exec &> >(tee -a "$log")

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`

#Check if /etc/skel/.local directory exists
if [ ! -e /etc/skel/.local ]; then
        sudo mkdir -p /etc/skel/.local/share/applications
	sudo mkdir -p /etc/skel/.local/share/desktop-directories
fi

#Remove old kernels
sudo apt-get -y autoremove --purge

#Remove apt cache
sudo apt-get -y clean

#Remove unnecessary kernels
sudo purge-old-kernels --keep 1

#Remove linux-headers
#sudo apt-get -y remove linux-headers-$(uname -a | awk '{ print $3 }')

#Remove virtualbox guest
sudo apt-get -y remove virtualbox-guest-*

#Copy config files based on Ubuntu
echo "Copy config files based on Ubuntu to /etc/skel ..."
cd $HOME
sudo rsync -rp --delete --progress ~/.config/user-dirs.dirs /etc/skel/.config/
sudo rsync -rp --delete --progress ~/.config/xfce4 /etc/skel/.config/
sudo chmod 755 /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
sudo rsync -rp --delete --progress ~/.config/menus /etc/skel/.config/
sudo rsync -rp --delete --progress ~/.config/Thunar /etc/skel/.config/
sudo rsync -rp --delete --progress ~/.local/share/applications /etc/skel/.local/share/
sudo rsync -rp --delete --progress ~/.local/share/desktop-directories /etc/skel/.local/share/
sudo rsync -rp --delete --progress ~/.bashrc /etc/skel/
sudo rsync -rp --delete --progress ~/.local/share/icons /etc/skel/.local/share/

#Copy neuroimaging-related files to /etc/skel
sudo rsync -rp --delete --progress ~/Desktop /etc/skel/
sudo rsync -rp --delete --progress ~/bin /etc/skel/
sudo rsync -rp --delete --progress ~/tutorial /etc/skel/
sudo mkdir /etc/skel/git
sudo rsync -rp --delete --progress ~/git/lin4neuro-xenial /etc/skel/git/

#Check if Document direcotry exists in /etc/skel
cd /etc/skel
if [ ! -e /etc/skel/Documents ]; then
        sudo mkdir Desktop Documents Downloads Music Pictures Public \
		   Templates Videos
fi

#ubiquity
sudo apt-get -y install ubiquity-frontend-gtk

#remove 40cdrom from ubiquity
if [ -e /usr/lib/ubiquity/apt-setup/generators/40cdrom ]; then
	sudo rm /usr/lib/ubiquity/apt-setup/generators/40cdrom
fi

#modify ubiquity.desktop
sudo sed -i 's/Exec=sh/Exec=sudo sh/' /usr/share/applications/ubiquity.desktop

#Remove unnecessary files
sudo apt-get -y autoremove

#Remastering with Remastersys
while true; do

	echo "Ready for remastering."
	echo "Do you want to proceed remastering with Remastersys (yes/no)?"

	read answer

	case $answer in
		[Yy]*)
			sudo wajig hold neurodebian-popularity-contest
			sudo remastersys clean
			sudo remastersys dist
			break
			;;
		[Nn]*)
			echo -e "Run Remastersys manually later.\n"
			exit
			;;
		*)
			echo -e "Type yes or no.\n"	
			;;
	esac
done

#Reinstall virtualbox-guest-dkms
sudo apt-get -y install virtualbox-guest-dkms

echo "Finished!"
sleep 5

exit

