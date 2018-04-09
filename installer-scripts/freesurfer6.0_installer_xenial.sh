#!/bin/bash
#freesurfer_6.0_installer.sh
#Script to install freesurfer v6.0.0.
#This script downloads required files, install them, and configure that
#subject directory is under $HOME

#12 Feb 2018 K. Nemoto

echo "Begin installation of FreeSurfer"
echo
echo "This script will download and install Freesurfer in Ubuntu 16.04"
echo "You need to prepare license.txt beforehand."
echo "license.txt should be placed in $HOME/Downloads"

while true; do

echo "Are you sure you want to begin the installation of FreeSurfer? (yes/no)"
read answer 
    case $answer in
        [Yy]*)
          echo "Begin installation."
	  break
          ;;
        [Nn]*)
          echo "Abort installation."
          exit 1
          ;;
        *)
          echo -e "Please type yes or no. \n"
          ;;
    esac
done

echo "Check if you have license.txt in $HOME/Downloads"

if [ -e $HOME/Downloads/license.txt ]; then
    echo "license.txt exists. Continue installation."
else
    echo "You need to prepare license.txt"
    echo "Abort installation. Please run the script after you put license.txt in $HOME/Downloads"
fi

# install libjpeg62
echo "install libjpeg62"
sudo apt install -y libjpeg62

# download freesurfer
if [ ! -e $HOME/Downloads/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz ]; then
	echo "Download Freesurfer to $HOME/Downloads"
	cd $HOME/Downloads
	wget -c ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
else
	echo "Freesurfer archive is found in $HOME/Downloads"
fi

# check the archive
cd $HOME/Downloads
echo "Check if the downloaded archive is not corrupt."
echo "d49e9dd61d6467f65b9582bddec653a4  freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz" > freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz.md5

md5sum -c freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz.md5

while [ "$?" -ne 0 ]; do
    echo "Filesize is not correct. Re-try downloading."
    wget -c ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
    md5sum -c freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz.md5
done

echo "Filesize is correct!"
rm freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz.md5

# install freesurfer
echo "Install freesurfer"
cd /usr/local
sudo tar xvzf $HOME/Downloads/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

if [ -d "/usr/local/freesurfer" ]; then
    sudo cp $HOME/Downloads/license.txt /usr/local/freesurfer
else
    echo "freesurfer is not extracted correctly."
    exit 1
fi

# prepare freesurfer directory in $HOME
echo "make freesurfer directory in $HOME"
cd $HOME
if [ ! -d freesurfer ]; then
    mkdir freesurfer
fi

cp -r /usr/local/freesurfer/subjects $HOME/freesurfer

# append to .bashrc
cat $HOME/.bashrc | grep 'SetUpFreeSurfer.sh'
if [ "$?" -eq 0 ]; then
    echo ".bashrc is already set."
else
    echo >> $HOME/.bashrc
    echo "#FreeSurfer" >> $HOME/.bashrc
    echo "export SUBJECTS_DIR=~/freesurfer/subjects" >> $HOME/.bashrc
    echo "export FREESURFER_HOME=/usr/local/freesurfer" >> $HOME/.bashrc
    echo 'source $FREESURFER_HOME/SetUpFreeSurfer.sh' >> $HOME/.bashrc
fi

# replace 'ln -s' with 'cp' for virtualbox environment
sudo sed -i 's/ln -s \$hemi/cp \$hemi/' /usr/local/freesurfer/bin/recon-all

echo "Installation finished!"
echo "Now close this terminal, open another terminal, and run fs_check_6.0.sh"

exit

