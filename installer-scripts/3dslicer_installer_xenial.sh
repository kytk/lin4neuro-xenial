#!/bin/bash

echo "Install 3D-Slicer"
cd $HOME/Downloads

if [ ! -e 'Slicer-4.10.1-linux-amd64.tar.gz' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/Slicer-4.10.1-linux-amd64.tar.gz
fi

cd /usr/local
#remove previous version
sudo rm -rf Slicer
sudo tar xvzf ~/Downloads/Slicer-4.10.1-linux-amd64.tar.gz
sudo mv Slicer-4.10.1-linux-amd64 Slicer

grep Slicer ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#Slicer' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/Slicer' >> ~/.bashrc
fi

#make icon show in the neuroimaging directory
sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/3dslicer.desktop

echo "Finished!"
sleep 5
exit
