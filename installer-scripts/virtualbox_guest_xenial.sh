#!/bin/bash

#Scripts to install virtualbox-guest and configure settings
sudo apt-get -y install virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

#prepare shared directory
if [ ! -e /media/sf_share ]; then
  echo "prepare shared directory"
  sudo mkdir /meida/sf_share
fi

#/etc/fstab
echo '' | sudo tee -a /etc/fstab
echo '#Virtualbox shared folder' | sudo tee -a /etc/fstab
echo 'share   /media/sf_share vboxsf    uid=1000,gid=1000    0    0' | sudo tee -a /etc/fstab

echo "Reboot system in 5 seconds"
sleep 5
sudo reboot

exit

