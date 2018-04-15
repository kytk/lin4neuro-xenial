#!/bin/bash

#Scripts to disable virtualbox shared folder
sudo umount /media/sf_share
sudo sed -i 's/^share/#share/' /etc/fstab

exit

