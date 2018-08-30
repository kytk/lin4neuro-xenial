#!/bin/bash
#cleanup_system.sh
#cleanup script for the system

echo "zeropad the unused space"
sudo dd if=/dev/zero of=zero bs=4k; sudo \rm zero

echo "remove old kernels"
sudo apt-get -y autoremove --purge

echo "remove apt cache"
sudo apt-get -y clean

echo "remove unnecessary kernels"
sudo purge-old-kernels

echo "remove logs"
cd ~/git/lin4neuro-bionic
ls | grep .log > /dev/null
if [ $? -eq 0 ]; then
    rm ~/git/lin4neuro-bionic/*.log
fi

echo "remove downloaded files"
cd ~/Downloads
fcount=$(ls | wc -l)
if [ $fcount != 0 ]; then
    rm -rf *
fi

echo "remove history"
export HISTSIZE=0; cd $HOME; rm .bash_history

exit

