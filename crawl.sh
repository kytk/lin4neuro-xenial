#!/bin/bash
#Crawler to check the current status of neuroimagin software packages

firefox http://download.slicer.org/ 
sleep 1
firefox -new-tab http://www.itksnap.org/pmwiki/pmwiki.php?n=Downloads.SNAP3 &
firefox -new-tab http://ric.uthscsa.edu/mango/mango.html &
firefox -new-tab https://www.nitrc.org/frs/?group_id=889 &
firefox -new-tab http://www.nitrc.org/frs/?group_id=152 &
firefox -new-tab https://afni.nimh.nih.gov/pub/dist/tgz/ &


