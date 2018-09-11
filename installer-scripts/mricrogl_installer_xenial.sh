#!/bin/bash

#MRIcroGL
echo "Install MRIcroGL"
cd $HOME/Downloads

if [ ! -e 'mricrogl_linux.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/mricrogl_linux.zip
fi

cd /usr/local
sudo unzip ~/Downloads/mricrogl_linux.zip
sudo mv mricrogl_lx mricrogl
cd mricrogl
sudo rm .DS_Store
sudo find -type f -exec chmod 644 {} \;
sudo find -type d -exec chmod 755 {} \;
sudo chmod 755 MRIcroGL dcm2niix pigz_mricron

grep mricrogl ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#MRIcroGL' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/mricrogl' >> ~/.bashrc
fi


