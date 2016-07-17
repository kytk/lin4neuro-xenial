#!/bin/bash
#Lin4Neuro making script part 2
#Customize UI into Lin4Neuro
#Prerequisite: You need to finish the build-l4n-part1.sh first.

#ChangeLog
#22-May-2016: Update for DSI_Studio
#20-May-2016: Modify for Xenial (16.04)
#14-Jan-2016: Merge Engilsh version with Japanese version.
#30-Nov-2015: Modify for English version
#25-Nov-2015: Add log function
#26-Nov-2015: Modify panel customization

log=`date +%Y-%m-%d`-part2.log
exec &> >(tee -a "$log")

#Setting of path of the setting scripts
base_path=~/git/lin4neuro-xenial/lin4neuro-parts


#Delete directories with Japanese names
if [ -e ./.lin4neuro_ja ] ; then
  cd
  if [ -e ドキュメント ]; then
        rm -r [!a-zA-Z0-9]*
  fi
fi

#Install plymouth-related files
sudo apt-get -y install plymouth-themes plymouth-label

#Installation of lin4neuro-logo
echo "Installation of lin4neuro-logo"
sudo cp -r ${base_path}/lin4neuro-logo /usr/share/plymouth/themes
sudo update-alternatives --install 					\
	/usr/share/plymouth/themes/default.plymouth 			\
	default.plymouth 						\
	/usr/share/plymouth/themes/lin4neuro-logo/lin4neuro-logo.plymouth \
	100
sudo update-initramfs -u -k all

#Installation of icons
echo "Installation of icons"
mkdir -p ~/.local/share/icons
cp ${base_path}/icons/* ~/.local/share/icons

#Installation of customized menu
echo "Installation of customized menu"
mkdir -p ~/.config/menus
cp ${base_path}/config/menus/xfce-applications.menu \
	~/.config/menus

#Installation of .desktop files
echo "Installation of .desktop files"
mkdir -p ~/.local/share/applications
cp ${base_path}/local/share/applications/* \
	~/.local/share/applications

#Installation of Neuroimaging.directory
echo "Installation of Neuroimaging.directory"
mkdir -p ~/.local/share/desktop-directories
cp ${base_path}/local/share/desktop-directories/Neuroimaging.directory ~/.local/share/desktop-directories

#Copy background image
echo "Copy background image"
sudo cp ${base_path}/backgrounds/deep_ocean.png /usr/share/backgrounds

#Remove an unnecessary image file
sudo rm /usr/share/backgrounds/xfce/xfce-teal.jpg

#Copy modified lightdm-gtk-greeter.conf
echo "Copy modified 01_ubuntu.conf"
sudo mkdir -p /usr/share/lightdm/lightdm-gtk-greeter.conf.d
sudo cp ${base_path}/lightdm/lightdm-gtk-greeter.conf.d/01_ubuntu.conf /usr/share/lightdm/lightdm-gtk-greeter.conf.d

#Settings for auto-login
echo "Settings for auto-login"
sudo mkdir -p /usr/share/lightdm/lightdm.conf.d
sudo cp ${base_path}/lightdm/lightdm.conf.d/10-ubuntu.conf \
	/usr/share/lightdm/lightdm.conf.d

#Customize panel 
echo "Customize panel"
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
cp ${base_path}/config/xfce-perchannel-xml/xfce4-panel.xml \
	~/.config/xfce4/xfconf/xfce-perchannel-xml/

cp -r ${base_path}/config/panel ~/.config/xfce4/

#Customize desktop
echo "Customize desktop"
cp ${base_path}/config/xfce-perchannel-xml/xfce4-desktop.xml \
	~/.config/xfce4/xfconf/xfce-perchannel-xml/

#Customize theme (Greybird)
echo "Customize theme (Greybird)"
cp ${base_path}/config/xfce-perchannel-xml/xfwm4.xml \
	~/.config/xfce4/xfconf/xfce-perchannel-xml/

#Clean packages
sudo apt-get -y autoremove

#Setting up Neurodebian repository
if [ -e ./.lin4neuro_en ] ; then
  wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | \
  sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
#  rm ./.lin4neuro_en 
elif [ -e ./.lin4neuro_ja ] ; then
  wget -O- http://neuro.debian.net/lists/xenial.jp.full | \
  sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
#  rm ./.lin4neuro_ja
fi
sudo apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9
sudo apt-get update

#Installation of FSL
echo "Installation of FSL"
sudo apt-get -y install fsl

#PATH settings
cat << FIN >> ~/.bashrc

#FSL
. /etc/fsl/fsl.sh

FIN

#Install MRIConvert
sudo apt-get install -y mriconvert

#Install prerequisite packages for AFNI
#sudo apt-get install -y tcsh xfonts-base python-qt4                    \
#                        libmotif4 libmotif-dev motif-clients           \
#                        gsl-bin netpbm gnome-tweak-tool libjpeg62
#sudo apt-get update
#sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so /usr/lib/libgsl.so.0
#sudo dpkg -i http://mirrors.kernel.org/ubuntu/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb
#sudo apt-get install -f


#Install prerequisite packages for DSI Studio
#sudo apt-get install -y libboost-thread1.58.0 libboost-program-options1.58.0 qt5-default

echo "Part 2 finished! Please reboot to reflect the customization."
