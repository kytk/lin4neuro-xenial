#!/bin/bash

#Scripts to install virtualbox-guest and configure settings
sudo apt-get -y install virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

echo "Reboot system in 10 seconds"
sleep 10
sudo reboot

exit

