#!/bin/bash

#MRIcroGL
echo "Install MRIcroGL"
cd $HOME/Downloads

if [ ! -e 'MRIcroGL_linux.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/MRIcroGL_linux.zip
fi

cd /usr/local
sudo unzip ~/Downloads/MRIcroGL_linux.zip

grep MRIcroGL ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#MRIcroGL' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/MRIcroGL' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/MRIcroGL/Resources' >> ~/.bashrc
fi


