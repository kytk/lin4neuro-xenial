#!/bin/bash
#Lin4Neuro making script part 2
#Installation of Virtualbox-related packages and Neuroimaging software packages
#Prerequisite: You need to finish the build-l4n-xenial-1.sh.
#Kiyotaka Nemoto 15-Apr-2018

#Changelog
#15-Apr-2018 move VirtualBox settings to the part 2
#07-Apr-2018 add symbolic link to installer

#Log
log=`date +%Y%m%d%H%M%S`-part2.log
exec &> >(tee -a "$log")

#Virtualbox-related settings
##Install the kernel header
sudo apt-get -y install linux-headers-$(uname -a | awk '{ print $3 }')

##Install virtualbox-guest-dkms
sudo apt-get install -y virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

##Virtualbox-related settings
sudo sh -c 'echo 'vboxsf' >> /etc/modules'

echo '' | sudo tee -a /etc/fstab
echo '#Virtualbox shared folder' | sudo tee -a /etc/fstab
echo '#share   /media/sf_share vboxsf    uid=1000,gid=1000    0    0' | sudo tee -a /etc/fstab


#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#R
sudo apt-key adv --keyserver keyserver.ubuntu.com \
     --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

echo "Install R using cran.rstudio.com repository"

grep rstudio /etc/apt/sources.list > /dev/null
if [ $? -eq 1 ]; then
  sudo add-apt-repository \
  'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
fi
sudo apt-get -y update
sudo apt-get install -y r-base

#MRIConvert
echo "Install MRI convert"
sudo apt-get install -y mriconvert

#VirtualMRI
echo "Install Virtual MRI"
sudo apt-get install -y virtual-mri-nonfree

#3D Slicer
echo "Install 3D Slicer"
cd $HOME/Downloads

if [ ! -e 'Slicer-4.8.1-linux-amd64.tar.gz' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/Slicer-4.8.1-linux-amd64.tar.gz
fi

cd /usr/local
sudo tar xvzf ~/Downloads/Slicer-4.8.1-linux-amd64.tar.gz
sudo mv Slicer-4.8.1-linux-amd64 Slicer

grep Slicer ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#Slicer' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/Slicer' >> ~/.bashrc
fi

#Aliza
echo "Install Aliza"
cd $HOME/Downloads

if [ ! -e 'aliza_1.38.2.6.deb' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/aliza_1.38.2.6.deb
fi

sudo apt install ./aliza_1.38.2.6.deb


#DSIStudio
echo "Install DSI Studio"
sudo apt-get install -y \
  libboost-thread1.58.0 libboost-program-options1.58.0 qt5-default

cd $HOME/Downloads

if [ ! -e 'dsistudio.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/dsistudio.zip
fi

cd /usr/local
sudo unzip ~/Downloads/dsistudio.zip

#ROBEX
echo "Install ROBEX"
cd $HOME/Downloads

if [ ! -e 'ROBEXv12.linux64.tar.gz' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/ROBEXv12.linux64.tar.gz
fi

cd /usr/local
sudo tar xvzf ~/Downloads/ROBEXv12.linux64.tar.gz
sudo chmod 755 ROBEX
cd ROBEX
sudo find -type f -exec chmod 644 {} \;
sudo chmod 755 ROBEX runROBEX.sh dat ref_vols

grep ROBEX ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#ROBEX' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/ROBEX' >> ~/.bashrc
fi

#c3d
echo "Install c3d"
cp -r ${base_path}/bin $HOME

cd $HOME/Downloads

if [ ! -e 'c3d-1.0.0-Linux-x86_64.tar.gz' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/c3d-1.0.0-Linux-x86_64.tar.gz
fi

cd /usr/local
sudo tar xvzf ~/Downloads/c3d-1.0.0-Linux-x86_64.tar.gz
sudo mv c3d-1.0.0-Linux-x86_64 c3d

grep c3d ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#c3d' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/c3d/bin' >> ~/.bashrc
    echo 'source $HOME/bin/bashcomp.sh' >> ~/.bashrc
fi

#itksnap
echo "Install ITK-SNAP"
cd $HOME/Downloads

if [ ! -e 'itksnap-3.6.0-20170401-Linux-x86_64.tar.gz' ]; then
  curl -O  http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/itksnap-3.6.0-20170401-Linux-x86_64.tar.gz
fi

cd /usr/local
sudo tar xvzf ~/Downloads/itksnap-3.6.0-20170401-Linux-x86_64.tar.gz
sudo mv itksnap-3.6.0-20170401-Linux-x86_64 itksnap

grep itksnap ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#ITK-SNAP' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/itksnap/bin' >> ~/.bashrc
fi

#Mango
echo "Install Mango"
cd $HOME/Downloads

if [ ! -e 'mango_unix.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/mango_unix.zip
fi

cd /usr/local
sudo unzip ~/Downloads/mango_unix.zip

#MRIcron
echo "Install MRIcron"
cd $HOME/Downloads

if [ ! -e 'lx.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/lx.zip
fi

cd /usr/local
sudo unzip ~/Downloads/lx.zip
sudo mv mricron_lx mricron
cd mricron
sudo find lut -type f -exec chmod 644 {} \;
sudo find templates -type f -exec chmod 644 {} \;

grep mricron ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#MRIcron' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/mricron' >> ~/.bashrc
fi

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

#tutorial
echo "Install tutorial by Chris Rorden"
cd $HOME/Downloads

if [ ! -e 'tutorial.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/tutorial.zip
fi

cd /etc/skel
sudo unzip ~/Downloads/tutorial.zip
sudo rm -rf __MACOSX
cd $HOME
unzip ~/Downloads/tutorial.zip
rm -rf __MACOSX

#packages to be installed by users (with installer)
#ANTs
#CONN17f
#FSL
#SPM12 standalone

ln -s ${currentdir}/installer ~/Desktop 

#Add the line above to .bashrc
cat << EOS >> ~/.bashrc

#symbolic links
if [ ! -L ~/Desktop/installer ]; then
   ln -fs ~/git/lin4neuro-xenial/installer ~/Desktop
fi

EOS

#PATH for installer

#grep installer-scripts ~/.bashrc > /dev/null
#if [ $? -eq 1 ]; then
#    echo '' >> ~/.bashrc
#    echo '#PATH for installer' >> ~/.bashrc
#    echo 'export PATH=$PATH:~/git/lin4neuro-xenial/installer-scripts' >> ~/.bashrc
#fi

echo "Finished!"

exit

