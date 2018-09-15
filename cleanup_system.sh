#!/bin/bash
#cleanup_system.sh
#cleanup script for the system

echo "remove old kernels"
sudo apt-get -y autoremove --purge
sudo purge-old-kernels

echo "remove apt cache"
sudo apt-get -y clean

echo "remove unnecessary configuration files"
dpkg -l | awk '/^rc/ {print $2}' | xargs sudo dpkg --purge

echo "clear /var/logs"
sudo find /var/log/ -type f -exec cp -f /dev/null {} \;

echo "remove lin4neuro logs"
cd ~/git/lin4neuro-xenial
ls | grep .log > /dev/null
if [ $? -eq 0 ]; then
    rm ~/git/lin4neuro-xenial/*.log
fi

echo "remove downloaded files"
cd ~/Downloads
fcount=$(ls | wc -l)
if [ $fcount != 0 ]; then
    rm -rf *
fi

echo "bleachbit"
sudo bleachbit -c --preset

echo "zeropad the unused space"
sudo dd if=/dev/zero of=zero bs=4k; sudo \rm zero

echo "remove history"
export HISTSIZE=0; cd $HOME; rm .bash_history

exit

