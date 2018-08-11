#!/bin/sh

#AFNI Installer
#This scripts install AFNI in /usr/local/AFNIbin

#This is based on https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/background_install/install_instructs/steps_linux_ubuntu16.html

#24 Dec 2017 K. Nemoto

cd $HOME

#Setup R
export R_LIBS=$HOME/R
mkdir $R_LIBS
echo 'export R_LIBS=$HOME/R' >> ~/.bashrc
#curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh
#sudo tcsh @add_rcran_ubuntu.tcsh
rPkgsInstall -pkgs ALL

#Make AFNI/SUMA profiles
cp /usr/local/AFNIbin/AFNI.afnirc $HOME/.afnirc
suma -update_env

#Install help
apsearch -update_all_afni_help

cat << EOS >> ~/.bashrc

ahdir=`apsearch -afni_help_dir`
if [ -f "$ahdir/all_progs.COMP.bash" ]
then
   . $ahdir/all_progs.COMP.bash
fi
EOS


#Evaluate setup
cd $HOME
echo "Check installation"
afni_system_check.py -check_all

#make icon show in the neuroimaging directory
sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/afni.desktop


echo "Finished"
sleep 5
exit

