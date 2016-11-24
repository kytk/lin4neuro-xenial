#!/bin/bash
#Remastering with Remastersys for XFCE on Ubuntu-mini 14.04
#Ver. 1.2
#23-Nov-2016 K. Nemoto

#Execute as a normal user!

#Check the script is run by a normal user
if [ "$(whoami)" = "root" ]; then
	echo "Run with normal user. Exiting."
	exit 1
fi

#Check if /etc/skel/.local directory exists
if [ ! -e /etc/skel/.local ]; then
        sudo mkdir -p /etc/skel/.local/share/applications
	sudo mkdir -p /etc/skel/.local/share/desktop-directories
fi

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
#sudo rsync -rp --delete --progress ~/Desktop /etc/skel/


#Check if Document direcotry exists in /etc/skel
cd /etc/skel
if [ ! -e /etc/skel/Documents ]; then
        sudo mkdir Desktop Documents Downloads Music Pictures Public \
		   Templates Videos bin
fi

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
			break
			;;
		*)
			echo -e "Type yes or no.\n"	
			;;
	esac
done

exit

