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

#Download and extract neuroimaging software packages and tutorial

#3D Slicer
#c3d
#ANTs
#itksnap
#MRIcroGL
#MRIcron
#ROBEX
#tutorial

exit
