#!/bin/bash
#A script to install python libraries for machine learning and Spyder3

#Installation of python libraries for machine learning
sudo -H pip3 install cmake numpy scipy matplotlib pyyaml h5py   \
        pydot-ng opencv-python keras jupyter pillow python-dateutil
sudo -H pip3 install tensorflow

#Installation of Spyder3
sudo -H pip3 install PyQtWebEngine spyder

