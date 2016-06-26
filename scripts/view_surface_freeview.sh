#!/bin/bash

if [ $# -lt 1 ]; then
 echo "IDを指定してください"
 echo "使い方: $0 ID"
 exit 1
fi 

freeview -f  \
$SUBJECTS_DIR/$1/surf/lh.pial:annot=aparc.annot:name=lh.pial_aparc:visible=0 \
$SUBJECTS_DIR/$1/surf/rh.pial:annot=aparc.annot:name=rh.pial_aparc:visible=0 \
$SUBJECTS_DIR/$1/surf/lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3::name=lh.inflated_thickness:visible=0 \
$SUBJECTS_DIR/$1/surf/rh.inflated:overlay=rh.thickness:overlay_threshold=0.1,3::name=rh.inflated_thickness:visible=0 \
$SUBJECTS_DIR/$1/surf/lh.inflated:visible=0 \
$SUBJECTS_DIR/$1/surf/rh.inflated:visible=0 \
$SUBJECTS_DIR/$1/surf/lh.white:visible=0 \
$SUBJECTS_DIR/$1/surf/rh.white:visible=0 \
$SUBJECTS_DIR/$1/surf/lh.pial \
$SUBJECTS_DIR/$1/surf/rh.pial \
--viewport 3d
