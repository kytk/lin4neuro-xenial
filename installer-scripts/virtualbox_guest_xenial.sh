#!/bin/bash

#Scripts to install virtualbox-guest and configure settings
sudo apt-get -y install virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

echo "Reboot system in 5 seconds"
sleep 5
sudo reboot

exit

