#!/bin/bash

echo "Install ANTs"
cd $HOME/Downloads

if [ ! -e 'ANTs.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/ANTs.zip
fi

cd /usr/local
sudo unzip ~/Downloads/ANTs.zip

grep ANTs ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#ANTs' >> ~/.bashrc
    echo 'export ANTSPATH=/usr/local/ANTs/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANTSPATH' >> ~/.bashrc
fi

echo "Finished!"
sleep 5
exit
