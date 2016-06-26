#!/bin/bash
# Script to setup spinal cord toolbox

if [ ! -d $HOME/Downloads/miniconda ]; then
	mkdir -p $HOME/Downloads/miniconda
	cd $HOME/Downloads/miniconda
	wget -O miniconda_installer.sh https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
	bash miniconda_installer.sh
fi

export PATH="/home/kiyotaka/miniconda2/bin:$PATH"
cd $HOME/Downloads

if [ -e spinalcordtoolbox_v2.2_linux.tar.gz ]; then
	tar xvzf spinalcordtoolbox_v2.2_linux.tar.gz 
	cd spinalcordtoolbox_v2.2_linux/
	./installer.py
else
	echo "Cannot find spinalcordtoolbox_v2.2_linux.tar.gz"
	echo "Please download the arcive in $HOME/Downloads"
	exit 1
fi

exit
