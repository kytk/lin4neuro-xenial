#!/bin/bash

#Part3: Check if software is installed.

#Add PATH settings to .bashrc
cat ${base_path}/bashrc/bashrc-addition.txt >> $HOME/.bashrc

#Source .bashrc
. ~/.bashrc

echo "Check if neuroimaging software is properly installed."

#AFNI
if [ ! -e ~/.afnirc ]; then
    cp /usr/local/afni/bin/AFNI.afnirc ~/.afnirc
else
    echo ".afnirc exists"
fi

if [ ! -e ~/.sumarc ]; then
    suma -update_env
else
    echo ".sumarc exists"
fi

afni &
wait

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

#FSLView
fslview

