#!/bin/bash
#CONN17f standalone installer

#Check MCR is installed
if [ ! -d /usr/local/MATLAB/MCR/v92 ]; then
  echo "Matlab Compiler Runtime needs to be installed first!"
  ~/git/lin4neuro-xenial/installer-scripts/mcr_v92_installer_ubuntu1604.sh
fi

#Download SPM12 standalone
echo "Download CONN17f standalone"
cd $HOME/Downloads

if [ ! -e 'conn17f_glnxa64.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/conn17f_glnxa64.zip
fi

cd /usr/local
sudo unzip ~/Downloads/conn17f_glnxa64.zip

sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/conn.desktop

#alias
echo '' >> ~/.bashrc
echo '#conn17f standalone' >> ~/.bashrc
echo "alias conn='/usr/local/conn_standalone/R2017a/run_conn.sh /usr/local/MATLAB/MCR/v92'" >> ~/.bashrc


echo "Finished! Run CONN from menu -> Neuroimaging -> CONN"
sleep 5 
exit

