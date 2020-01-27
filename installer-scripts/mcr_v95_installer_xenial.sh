#!/bin/bash
#Install Matlab R2018b Runtime

echo "Install Matlab R2018b (v95) Runtime"
cd $HOME/Downloads

if [ ! -e 'MCR_R2018b_glnxa64_installer.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/MCR_R2018b_glnxa64_installer.zip
fi

mkdir mcr
cd mcr
unzip ../MCR_R2018b_glnxa64_installer.zip

#Install to /usr/local/MATLAB/MCR/v95
sudo ./install -mode silent -agreeToLicense yes \
    -destinationFolder /usr/local/MATLAB/MCR/v95

echo "Finished!"

exit

