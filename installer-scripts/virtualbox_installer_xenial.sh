#!/bin/bash

#Add repository for Virtualbox

aptlist=/etc/apt/sources.list

echo '' | sudo tee -a $aptlist
echo '#VirtualBox' | sudo tee -a $aptlist
echo 'deb https://download.virtualbox.org/virtualbox/debian xenial contrib' \
	| sudo tee -a $aptlist

#Public key for apt-secure
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- \
	| sudo apt-key add -

#Install VirtualBox
sudo apt-get update
sudo apt-get -y install virtualbox-5.2

#Only for guest
# sudo apt-get -y install virtualbox-guest-dkms
# sudo usermod -aG vboxsf $(whoami)

exit

