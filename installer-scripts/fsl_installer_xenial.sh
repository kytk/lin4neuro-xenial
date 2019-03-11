#!/bin/bash

cp ~/git/lin4neuro-bionic/lin4neuro-parts/local/share/applications/fsl*.desktop ~/.local/share/applications
sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fsl-wiki.desktop

fslinstalled=$(which fsl)
if [ -z "$fslinstalled" ]; then
  echo "FSL is not installed yet."
  echo "FSL is to be installed with fslinstaller.py"
  echo "checking if fslinstaller.py is downloaded."
  fslpyexist=$(find ~/ -name fslinstaller.py)

  if [ -z "$fslpyexist" ]; then
    echo "Please download fslinstaller.py first"
    echo "Please run the script after you installed fslinstaller.py"
    sleep 5
    xdg-open "https://fsl.fmrib.ox.ac.uk/fsldownloads_registration" 
    exit

  else
    echo "found fslinstaller.py"
    cp $fslpyexist .
    python2 fslinstaller.py
  fi

else
  echo "FSL is already installed."
  echo "Do you want to check the update?(yes/no)"
  read answer
  case $answer in 
	[Yy]*)
		cp $FSLDIR/etc/fslinstaller.py .
		python2 fslinstaller.py -c
		sleep 5
		break
		;;
	[Nn]*)
		echo -e "FSL will not be updated.\n"
		sleep 5
		exit
  		;;
	*)
		echo -e "Type yes or no.\n"
		;;
  esac

fi

exit

