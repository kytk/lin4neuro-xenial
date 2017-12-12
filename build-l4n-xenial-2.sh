#!/bin/bash
#Lin4Neuro making script part 2
#Customize UI into Lin4Neuro
#Prerequisite: You need to finish the build-l4n-part1.sh first.

#ChangeLog
#12-Dec-2017: Update install of AFNI
#09-Dec-2017: Comment out FSL
#26-Jun-2017: Add symbolic link (libgsl.so.0) for AFNI
#17-Jun-2017: Change prerequisite for AFNI based on official site
#17-Jun-2017: Add virtualbox-guest-dkms
#16-Jun-2017: Bug fix for GRUB
#22-May-2016: Update for DSI_Studio
#20-May-2016: Modify for Xenial (16.04)
#14-Jan-2016: Merge Engilsh version with Japanese version
#30-Nov-2015: Modify for English version
#25-Nov-2015: Add log function
#26-Nov-2015: Modify panel customization

log=`date +%Y-%m-%d`-part2.log
exec &> >(tee -a "$log")

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#Install plymouth-related files
sudo apt -y install plymouth-themes plymouth-label

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
#mkdir -p ~/.local/share/icons
cp -r ${base_path}/icons ~/.local/share/

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
sudo apt -y autoremove

#GRUB setting for plymouth
echo 'GRUB_GFXPAYLOAD_LINUX="auto"' | sudo tee -a /etc/default/grub 
sudo sh -c 'echo 'FRAMEBUFFER=y' > /etc/initramfs-tools/conf.d/splash'
sudo update-grub

#(Optional)Display GRUB menu
sudo sed -i -e 's/GRUB_HIDDEN_TIMEOUT/#GRUB_HIDDEN_TIMEOUT/' /etc/default/grub
sudo update-grub

#Installation of FSL
#echo "Installation of FSL"
#sudo apt -y update
#sudo apt -y upgrade
#sudo apt -y install fsl fsl-5.0-doc-wiki fsl-5.0-doc-wikiattachments
#sudo apt-get -f install

#PATH settings
#if ! grep -q -i 'fsl.sh' ~/bashrc; then
#cat << FIN >> ~/.bashrc
##FSL
#. /etc/fsl/fsl.sh
#FIN
#fi
#
##modification for FSL-doc
#sudo mkdir /usr/share/fsl/5.0/doc/redirects
#sudo tee /usr/share/fsl/5.0/doc/redirects/index.html <<FIN >/dev/null
#<meta http-equiv="refresh" content="0; url=file:///usr/share/fsl/5.0/doc/wiki/FSL.html" />
#FIN

#Install MRIConvert
#sudo apt install -y mriconvert

#Install R
sudo apt install -y software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
sudo apt -y update
sudo apt install -y r-base

#Install prerequisite packages for AFNI
#(https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/steps_linux_ubuntu16.html) 12 Dec 2017
sudo apt install -y tcsh xfonts-base python-qt4       \
                    gsl-bin netpbm gnome-tweak-tool   \
		    libjpeg62 xvfb vim curl
sudo apt install -y libglu1-mesa-dev libglw1-mesa     \
                   libxm4 build-essential
#We have to make a symbolic link for libgsl
sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.19.0.0 /usr/lib/x86_64-linux-gnu/libgsl.so.0

#Download AFNI installer to $HOME
cd $HOME
curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_ubuntu_16_64/@update.afni.binaries
#sudo tcsh @update.afni.binaries -package linux_ubuntu_16_64 -bindir /usr/local/AFNIbin/ -do_extras


#Install prerequisite packages for DSI Studio
sudo apt install -y libboost-thread1.58.0 libboost-program-options1.58.0 qt5-default

#Copy bashcom.sh for c3d to ~/bin
cp -r ${base_path}/bin $HOME

#Install virtualbox-guest-dkms
sudo apt install -y virtualbox-guest-dkms
sudo usermod -aG vboxsf $(whoami)

echo "Part 2 finished! The system will reboot to reflect the customization."
echo "Please install several packages later."
sleep 5
echo "System reboot"
sudo reboot

