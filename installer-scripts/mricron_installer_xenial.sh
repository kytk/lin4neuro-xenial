#!/bin/bash

#MRIcron
echo "Install MRIcron"
cd $HOME/Downloads

if [ ! -e 'lx.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/lx.zip
fi

cd /usr/local
sudo unzip ~/Downloads/lx.zip
sudo mv mricron_lx mricron
cd mricron
sudo find lut -type f -exec chmod 644 {} \;
sudo find templates -type f -exec chmod 644 {} \;

grep mricron ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#MRIcron' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/mricron' >> ~/.bashrc
fi


