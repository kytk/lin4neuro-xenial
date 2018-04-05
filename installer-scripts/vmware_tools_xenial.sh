#!/bin/bash

#Scripts to install vmware-tools and configure settings
echo "install open-vm-tools for VMware."
sudo apt-get -y install open-vm-tools open-vm-tools-desktop 

echo "Reboot system in 10 seconds"
sleep 10
sudo reboot

exit

