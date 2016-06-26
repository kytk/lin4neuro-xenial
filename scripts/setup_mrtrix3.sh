#!/bin/bash
#Script to setup mrtrix3 for Ubuntu 14.04

#Install prerequisite packages
sudo apt-get install git g++ python libgsl0-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libqt5svg5*

#Download MRtrix3 source
cd $HOME/git
git clone https://github.com/MRtrix3/mrtrix3.git

#Configuration and build
cd mrtrix3
./configure
./build

#.bashrc
echo >> $HOME/.bashrc
echo "#MRtrix3" >> $HOME/.bashrc
echo 'export PATH=$PATH:$HOME/git/mrtrix3/bin:$HOME/git/mrtrix3/scripts' >> $HOME/.bashrc


