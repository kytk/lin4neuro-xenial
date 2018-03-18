#!/bin/bash
#SPM12 standalone installer

#Check MCR is installed
if [ ! -d /usr/local/MATLAB/MCR/v92 ]; then
  echo "Matlab Compiler Runtime needs to be installed first!"
  mcr_v92_installer_ubuntu1604.sh
fi

#Download SPM12 standalone
echo "Download SPM12 standalone"
cd $HOME/Downloads

if [ ! -e 'spm12_standalone.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/spm12_standalone.zip
fi

cd /usr/local
sudo unzip ~/Downloads/spm12_standalone.zip

sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/spm.desktop

echo "Initialize SPM12 standalone"
echo "Press Quit when SPM12 is up"
sleep 5
sudo /usr/local/spm12_standalone/run_spm12.sh /usr/local/MATLAB/MCR/v92

exit

