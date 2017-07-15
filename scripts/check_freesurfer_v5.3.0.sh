#!/bin/bash

echo "Test the installation."

echo "freeview. Close the window to proceed the script."

freeview -v $SUBJECTS_DIR/bert/mri/brainmask.mgz -v \
$SUBJECTS_DIR/bert/mri/aseg.mgz:colormap=lut:opacity=0.2 -f \
$SUBJECTS_DIR/bert/surf/lh.white:edgecolor=yellow -f \
$SUBJECTS_DIR/bert/surf/rh.white:edgecolor=yellow -f \
$SUBJECTS_DIR/bert/surf/lh.pial:annot=aparc:edgecolor=red -f \
$SUBJECTS_DIR/bert/surf/rh.pial:annot=aparc:edgecolor=red 

echo "tkmedit. Close the window to proceed the script." 
tkmedit bert orig.mgz 

echo "tksurfer. Close the window to proceec the script."
tksurfer bert rh pial




