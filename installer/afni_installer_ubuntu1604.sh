#!/bin/sh

#AFNI Installer
#This scripts install AFNI in /usr/local/AFNIbin

#This is based on https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/steps_linux_ubuntu16.html

#24 Dec 2017 K. Nemoto

#Install prerequisite packages
sudo apt update
sudo aptinstall -y tcsh xfonts-base python-qt4       \
                   gsl-bin netpbm gnome-tweak-tool   \
                   libjpeg62 xvfb xterm vim curl

sudo apt install -y libglu1-mesa-dev libglw1-mesa     \
                    libxm4 build-essential

#Download installer
cd $HOME
curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_ubuntu_16_64/@update.afni.binaries

#Install to /usr/local/AFNIbin
sudo tcsh @update.afni.binaries -package linux_ubuntu_16_64 -bindir /usr/local/AFNIbin -do_extras

#Source .bashrc
source ~/.bashrc

#Setup R
export R_LIBS=$HOME/R
mkdir $R_LIBS
echo 'export R_LIBS=$HOME/R' >> ~/.bashrc
curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh
sudo tcsh @add_rcran_ubuntu.tcsh
rPkgsInstall -pkgs ALL

#Make AFNI/SUMA profiles
cp $HOME/abin/AFNI.afnirc $HOME/.afnirc
suma -update_env

#Evaluate setup
cd $HOME
afni_system_check.py -check_all


