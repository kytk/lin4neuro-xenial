#!/bin/bash

#ROBEX
echo "Install ROBEX"
cd $HOME/Downloads

if [ ! -e 'ROBEXv12.linux64.tar.gz' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/ROBEXv12.linux64.tar.gz
fi

cd /usr/local
sudo tar xvzf ~/Downloads/ROBEXv12.linux64.tar.gz
sudo chmod 755 ROBEX
cd ROBEX
sudo find -type f -exec chmod 644 {} \;
sudo chmod 755 ROBEX runROBEX.sh dat ref_vols

grep ROBEX ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#ROBEX' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/ROBEX' >> ~/.bashrc
fi

