#!/bin/bash

#Part3: Check if software is installed.

#Source .bashrc
. ~/.bashrc

echo "Check if neuroimaging software is properly installed."


#Slicer
echo "Run Slicer"
Slicer &
wait

#c3d
echo "Run c3d"
c3d -h

#ITK-SNAP
echo "Run itksnap"
itksnap &
wait

#MRIcroGL
echo "Run MRIcroGL"
MRIcroGL &
wait


#MRIcron
echo "Run MRIcroN"
mricron &
wait

#ROBEX
echo "Run ROBEX"
ROBEX

echo "Finish checking!"

exit

