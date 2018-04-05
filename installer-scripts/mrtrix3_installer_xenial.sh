#!/bin/bash
#Script to setup mrtrix3 for Ubuntu 16.04

#Install prerequisite packages
echo "Begin installation of MRtrix3"
echo "Install prerequisite packages"
sudo apt-get install git g++ python libgsl0-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libqt5svg5* libeigen3-dev

#Download MRtrix3 source
echo "Download MRtrix3 source"
if [ ! -e $HOME/git ]; then
 mkdir $HOME/git
fi

cd $HOME/git
git clone https://github.com/MRtrix3/mrtrix3.git

#Configuration and build
echo "Configure and Build MRtrix3"
cd mrtrix3
./configure
./build

#.bashrc
echo "Add path to ~/.bashrc"
echo >> $HOME/.bashrc
echo "#MRtrix3" >> $HOME/.bashrc
echo 'export PATH=$PATH:$HOME/git/mrtrix3/bin:$HOME/git/mrtrix3/scripts' >> $HOME/.bashrc

echo "Finished!"
sleep 5

exit

