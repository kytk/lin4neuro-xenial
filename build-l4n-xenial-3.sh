#!/bin/bash
#Lin4Neuro making script part 3
#Installation of Neuroimaging software packages
#Prerequisite: You need to finish the build-l4n-part{1,2}.sh.

log=`date +%Y-%m-%d`-part2.log
exec &> >(tee -a "$log")

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#MRIConvert
sudo apt install -y mriconvert

#VirtualMRI
sudo apt install -y virtual-mri-nonfree

#Install prerequisite packages for DSI Studio
sudo apt install -y libboost-thread1.58.0 libboost-program-options1.58.0 qt5-default

#Copy bashcom.sh for c3d to ~/bin
cp -r ${base_path}/bin $HOME

#packages to be installed as a default


#ROBEX
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/ROBEXv12.linux64.tar.gz
cd /usr/local
sudo tar xvzf ~/Downloads/ROBEXv12.linux64.tar.gz
cd ROBEX
sudo find -type f -exec chmod 644 {} \;
sudo chmod 755 ROBEX runROBEX.sh dat ref_vols

grep ROBEX ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo "" >> ~/.bashrc
    echo "#ROBEX" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/local/ROBEX" >> ~/.bashrc
fi

#c3d
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/c3d-1.0.0-Linux-x86_64.tar.gz
cd /usr/local
sudo tar xvzf ~/Downloads/c3d-1.0.0-Linux-x86_64.tar.gz
sudo mv c3d-1.0.0-Linux-x86_64 c3d

grep c3d ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo "" >> ~/.bashrc
    echo "#c3d" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/local/c3d" >> ~/.bashrc
fi

#Mango
#MRIcron
#MRIcroGL
#tutorial

#packages to be installed by users (with installer)
#3D Slicer
#ANTs
#itksnap
#CONN17f
#SPM12 standalone

exit
