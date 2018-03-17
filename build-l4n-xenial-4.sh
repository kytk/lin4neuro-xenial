#!/bin/bash

#Part4: Check if software is installed.

#Setting of path of the setting scripts
currentdir=`echo $(cd $(dirname $0) && pwd)`
base_path=$currentdir/lin4neuro-parts

#Add PATH settings to .bashrc
#existrobex=`grep '#ROBEX' ~/.bashrc`
#if [ "$existrobex" != "#ROBEX" ]; then
#    cat ${base_path}/bashrc/bashrc-addition.txt >> $HOME/.bashrc
#else
#    echo ".bashrc setting is already done."
#fi

#Source .bashrc
. ~/.bashrc

echo "Check if neuroimaging software is properly installed."

#AFNI
#if [ ! -e ~/.afnirc ]; then
#    cp /usr/local/afni/bin/AFNI.afnirc ~/.afnirc
#else
#    echo ".afnirc exists"
#fi
#
#if [ ! -e ~/.sumarc ]; then
#    suma -update_env
#else
#    echo ".sumarc exists"
#fi
#
#afni_system_check.py -check_all
#wait

#Slicer
Slicer &

#c3d
c3d

#ANTs
ANTS

#ITK-SNAP
itksnap &
wait

#MRIcroGL
MRIcroGL &
wait


#MRIcron
mricron &
wait

#ROBEX
ROBEX

#FSL
fsl &
wait

#FSLeyes
fsleyes &

