#!/bin/bash

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
    python fslinstaller.py
  fi

else
  echo "FSL is already installed."
fi

sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fsl-wiki.desktop

exit

