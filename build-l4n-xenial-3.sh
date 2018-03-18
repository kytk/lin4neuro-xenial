#!/bin/bash

#Part3: Check if software is installed.

#Source .bashrc
. ~/.bashrc

echo "Check if neuroimaging software is properly installed."


#Slicer
"Run Slicer"
Slicer &
wait

#c3d
"Run c3d"
c3d

#ITK-SNAP
"Run itksnap"
itksnap &
wait

#MRIcroGL
"Run MRIcroGL"
MRIcroGL &
wait


#MRIcron
"Run MRIcroN"
mricron &
wait

#ROBEX
"Run ROBEX"
ROBEX

"Finish checking!"

