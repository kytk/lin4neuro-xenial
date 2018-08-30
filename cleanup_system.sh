#!/bin/bash
#zeropadding the unused space
sudo dd if=/dev/zero of=zero bs=4k; sudo \rm zero

#Remove old kernels
sudo apt-get -y autoremove --purge

#Remove apt cache
sudo apt-get -y clean

#Remove unnecessary kernels
sudo purge-old-kernels

#Remove logs
rm ~/git/lin4neuro-bionic/*.log

#Remove downloads
rm ~/Downloads/*

#Remove history
export HISTSIZE=0; cd $HOME; rm .bash_history

exit

