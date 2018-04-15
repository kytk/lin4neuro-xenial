#!/bin/bash

#Scripts to enable virtualbox shared folder
sudo sed -i 's/#share/share/' /etc/fstab
sudo mount -a

exit

