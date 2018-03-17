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

#3D Slicer

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
    echo "source $HOME/bin/bashcomp.sh" >> ~/.bashrc
fi

#itksnap
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/itksnap-3.6.0-20170401-Linux-x86_64.tar.gz
cd /usr/local
sudo tar xvzf ~/Downloads/itksnap-3.6.0-20170401-Linux-x86_64.tar.gz
sudo mv itksnap-3.6.0-20170401-Linux-x86_64 itksnap

grep itksnap ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo "" >> ~/.bashrc
    echo "#ITK-SNAP" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/local/itksnap/bin" >> ~/.bashrc
fi


#Mango
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/mango_unix.zip
cd /usr/local
sudo tar xvzf ~/Downloads/mango_unix.zip

#MRIcron
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/lx.zip
cd /usr/local
sudo unzip ~/Downloads/lx.zip
sudo mv mricron_lx mricron
cd mricron
sudo find lut -type f -exec chmod 644 {} \;
sudo find templates -type f -exec chmod 644 {} \;

grep mricron ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo "" >> ~/.bashrc
    echo "#MRIcron" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/local/mricron" >> ~/.bashrc
fi


#MRIcroGL
cd $HOME/Downloads
wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/mricrogl_linux.zip
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
    echo "" >> ~/.bashrc
    echo "#MRIcroGL" >> ~/.bashrc
    echo "export PATH=$PATH:/usr/local/mricrogl" >> ~/.bashrc
fi

#tutorial

#packages to be installed by users (with installer)
#ANTs
#CONN17f
#SPM12 standalone

exit
