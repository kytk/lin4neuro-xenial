#!/bin/bash

if [ $# -lt 1 ]; then
 echo "IDを指定してください"
 echo "使い方: $0 ID"
 exit 1
fi 

freeview -v \
$SUBJECTS_DIR/$1/mri/T1.mgz \
$SUBJECTS_DIR/$1/mri/wm.mgz \
$SUBJECTS_DIR/$1/mri/brainmask.mgz \
$SUBJECTS_DIR/$1/mri/aseg.mgz:colormap=lut:opacity=0.2 \
-f $SUBJECTS_DIR/$1/surf/lh.white:edgecolor=blue \
$SUBJECTS_DIR/$1/surf/lh.pial:edgecolor=red \
$SUBJECTS_DIR/$1/surf/rh.white:edgecolor=blue \
$SUBJECTS_DIR/$1/surf/rh.pial:edgecolor=red
