#!/bin/bash

fslinstalled=$(which fsl)
if [ $fslinstalled != /usr/local/fsl/bin/fsl ]; then
  echo "FSL is not installed yet."
  echo "FSL is to be installed with fslinstaller.py"
  python fslinstaller.py
else
  echo "FSL is already installed."
fi

