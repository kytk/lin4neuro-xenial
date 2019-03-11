#!/bin/bash
#Lin4Neuro making script part 2
#Installation of Neuroimaging software packages
#Prerequisite: You need to finish the build-l4n-xenial-1.sh.
#Kiyotaka Nemoto 12-Mar-2019

#Changelog
#12-Mar-2019 Harmonize with build-l4n-bionic-2.sh
#16-Aug-2018 Update DSI studio
#10-Aug-2018 Update Aliza
#14-Jul-2018 Add DCMTK
#15-Apr-2018 move VirtualBox settings and update the Libreoffice to the part 2
#07-Apr-2018 add symbolic link to installer

#Log
log=$(date +%Y%m%d%H%M%S)-part2.log
exec &> >(tee -a "$log")

<<<<<<< HEAD
#Signature for Neurodebian
=======
#Virtualbox-related settings
##Install the kernel header
sudo apt-get -y install linux-headers-$(uname -a | awk '{ print $3 }')

##Install virtualbox-guest-dkms
sudo apt-get install -y virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

##Virtualbox-related settings
#sudo sh -c 'echo 'vboxsf' >> /etc/modules'

echo '' | sudo tee -a /etc/fstab
echo '#Virtualbox shared folder' | sudo tee -a /etc/fstab
echo '#share   /media/sf_share vboxsf    _netdev,uid=1000,gid=1000    0    0' | sudo tee -a /etc/fstab

#sudo mkdir /media/sf_share

#Signature for neurodebian
>>>>>>> 51d14308607d4c7eab4585e1de8c20d095fe3e12
sudo apt-key add neuro.debian.net.asc

#Libreoffice
sudo add-apt-repository -y ppa:libreoffice/ppa
sudo apt-get update
sudo apt-get -y dist-upgrade

#Setting of path of the setting scripts
currentdir=$(cd $(dirname $0) && pwd)
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

#DCMTK
echo "Install DCMTK"
sudo apt-get install -y dcmtk

#MRIConvert
echo "Install MRI convert"
sudo apt-get install -y mriconvert

#VirtualMRI
echo "Install Virtual MRI"
<<<<<<< HEAD
cd "$HOME"/Downloads

if [ ! -e 'vmri.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/vmri.zip
fi

cd /usr/local
sudo unzip ~/Downloads/vmri.zip
=======
sudo apt-get install -y virtual-mri-nonfree

#3D Slicer
#echo "Install 3D Slicer"
#cd $HOME/Downloads
#
#if [ ! -e 'Slicer-4.8.1-linux-amd64.tar.gz' ]; then
#  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/Slicer-4.8.1-linux-amd64.tar.gz
#fi
#
#cd /usr/local
#sudo tar xvzf ~/Downloads/Slicer-4.8.1-linux-amd64.tar.gz
#sudo mv Slicer-4.8.1-linux-amd64 Slicer
#
#grep Slicer ~/.bashrc > /dev/null
#if [ $? -eq 1 ]; then
#    echo '' >> ~/.bashrc
#    echo '#Slicer' >> ~/.bashrc
#    echo 'export PATH=$PATH:/usr/local/Slicer' >> ~/.bashrc
#fi
>>>>>>> 51d14308607d4c7eab4585e1de8c20d095fe3e12

#Aliza
echo "Install Aliza"
cd "$HOME"/Downloads

if [ ! -e 'aliza_1.48.8.8.deb' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/aliza_1.48.8.8.deb
fi

sudo apt install -y ./aliza_1.48.8.8.deb

#DSIStudio
echo "Install DSI Studio"
sudo apt-get install -y \
  libboost-thread1.58.0 libboost-program-options1.58.0 qt5-default

cd $HOME/Downloads

if [ ! -e 'dsistudio1604.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/dsistudio1604.zip
fi

cd /usr/local
sudo unzip ~/Downloads/dsistudio1604.zip

#ROBEX
echo "Install ROBEX"
cd "$HOME"/Downloads

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
cp -r "${base_path}"/bin "$HOME"

cd "$HOME"/Downloads

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
cd "$HOME"/Downloads

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
cd "$HOME"/Downloads

if [ ! -e 'mango_unix.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/mango_unix.zip
fi

cd /usr/local
sudo unzip ~/Downloads/mango_unix.zip

#MRIcron
echo "Install MRIcron"
cd "$HOME"/Downloads

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
cd "$HOME"/Downloads

if [ ! -e 'MRIcroGL12_linux.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/MRIcroGL12_linux.zip
fi

cd /usr/local
sudo unzip ~/Downloads/MRIcroGL12_linux.zip

grep mricrogl ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
    echo '' >> ~/.bashrc
    echo '#MRIcroGL' >> ~/.bashrc
    echo 'export PATH=$PATH:/usr/local/MRIcroGL12' >> ~/.bashrc
fi

#tutorial
echo "Install tutorial by Chris Rorden"
cd "$HOME"/Downloads

if [ ! -e 'tutorial.zip' ]; then
  curl -O http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/tutorial.zip
fi

cd "$HOME"
unzip ~/Downloads/tutorial.zip

#Remove MacOS hidden files
find "$HOME" -name '__MACOSX' -exec rm -rf {} \;
find "$HOME" -name '.DS_Store' -exec rm -rf {} \;
#sudo find /usr/local -name '__MACOSX' -exec sudo rm -rf {} \;
#sudo find /usr/local -name '.DS_Store' -exec sudo rm -rf {} \;

#packages to be installed by users (with installer)
#ANTs
#CONN
#FSL
#Slicer
#SPM12

#Add the symbolic link to the installer to ~/.profile
cat << EOS >> ~/.profile

#symbolic links
if [ ! -L ~/Desktop/installer ]; then
   ln -fs ~/git/lin4neuro-xenial/installer ~/Desktop
fi

EOS


echo "Finished!"

exit

