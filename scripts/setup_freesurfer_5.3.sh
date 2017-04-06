#!/bin/bash
#setup_freesurfer.sh
#Script to install freesurfer v5.3.0.
#This script downloads required files, install them, and configure that
#subject directory is under $HOME

#24 Jan 2016 K. Nemoto

echo "Begin installation of FreeSurfer"
echo
echo "This script will download and install Freesurfer in Ubuntu 14.04"
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
sudo apt-get install -y libjpeg62

# download freesurfer
echo "Download Freesurfer to $HOME/Downloads"
cd $HOME/Downloads
wget -c ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/5.3.0/freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz

# check the archive
echo "Check if the downloaded archive is not corrupt."
echo "7c03e796e9b81ee69aaa60079c4094f20b945c08  freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz" > freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz.sha1

sha1sum -c freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz.sha1

if [ "$?" -eq 0 ]; then
    echo "Filesize is correct!"
    rm freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz.sha1
else
    echo "Download failed. Re-run the script again."
    echo "Abort."
    exit 1
fi

# install freesurfer
echo "Install freesurfer"
sudo cp $HOME/Downloads/freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz /usr/local
cd /usr/local
sudo tar xvzf freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz

if [ -d "/usr/local/freesurfer" ]; then
    sudo cp $HOME/Downloads/license.txt /usr/local/freesurfer
    sudo rm freesurfer-Linux-centos6_x86_64-stable-pub-v5.3.0.tar.gz
else
    echo "freesurfer is note extracted correctly."
    exit 1
fi

# prepare freesurfer directory in $HOME
echo "make freesurfer directory in $HOME"
cd $HOME
if [ ! -d freesurfer ]; then
    mkdir freesurfer
fi

cp -r /usr/local/freesurfer/subjects $HOME/freesurfer

# modify SetUpFreeSurfer.sh
sudo sed -i -e 's@$FREESURFER_HOME/subjects@$HOME/freesurfer/subjects@' \
     /usr/local/freesurfer/SetUpFreeSurfer.sh

# append to .bashrc
cat $HOME/.bashrc | grep 'SetUpFreeSurfer.sh'
if [ "$?" -eq 0 ]; then
    echo ".bashrc is already set."
else
    echo >> $HOME/.bashrc
    echo "#FreeSurfer" >> $HOME/.bashrc
    echo "export FREESURFER_HOME=/usr/local/freesurfer" >> $HOME/.bashrc
    echo 'source $FREESURFER_HOME/SetUpFreeSurfer.sh' >> $HOME/.bashrc
fi

echo "Installation finished!"
echo "Now close this terminal, open another terminal, and run check_freesurfer.sh"

exit

