# lin4neuro-xenial
Building script of Lin4Neuro based on Ubuntu-mini 16.04 (xenial)

This repository includes scripts to make Lin4Neuro from Ubuntu-mini.iso.
It also includes installer-scripts for several neuroimaging software.

# How to make Lin4Neuro with your own

## Install Ubuntu-mini.iso

You can get iso of ubuntu 16.04 from http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/current/images/netboot/mini.iso

Install with this iso and select **no packages** during installation.

## Install git and clone this repository

After installation, login and clone this repository.

```
sudo apt install git
mkdir ~/git
cd ~/git
git clone https://github.com/kytk/lin4neuro-xenial.git
```

## Install the Lin4Neuro-base

First, run **build-l4n-xenial-1.sh**.

```
cd ~/git/lin4neuro-xenial
./build-l4n-xenial-1.sh
```

The script will bring a prompt as following;

```
    Which language do you want to build? (English/Japanese)
    1) English
    2) Japanese
    3) quit
    #? 
```

Choose 1 or 2 depending on your language.

Then XFCE4.12 is installed. Upon installation, the system automatically reboots.

## Installation of Neuroimaging software packages

Then, run **build-l4n-xenial-2.sh**.

```
cd ~/git/lin4neuro-xenial
./build-l4n-xenial-1.sh
```

This will install several neuroimaging software packages listed below.

* 3D Slicer
* Aliza
* C3D
* DSI Studio
* ITK-SNAP
* Mango
* MRIcroGL
* MRIcron
* ROBEX
* Virtual MRI

## Check the software packages are installed correctly.

After installation of the software above, run **build-l4n-xenial-3.sh**.

```
./build-l4n-xenial-3.sh
```

This script simply tries to run software listed above.
If it is not installed correctly, you will see error messages in the terminal. Check it and correct.

## Prepare for remastering

If everything is set, run **build-l4n-xenial-4.sh**.

```
cd ~/git/lin4neuro-xenial
./build-l4n-xenial-4.sh
```

This will install customized Remastersys. Since remastersys stops developing, we customized the remastersys so it works for our need.

Configuration of remastersys is found in /etc/remastersys.conf

Modify the setting as you wish.

<!---
## (optional but important) Change UID in casper

If you work under VirtualBox circumstance, you need to do the following.
When you use VirtualBox Guest Additions, you need to add your username to vboxsf group. The id of vboxsf will be 999, which conflicts with uid of the user (custom) in live media. In order to avoid the conflict, change uid in casper settings.

    $ cd /usr/share/initramfs-tools/scripts/casper-bottom
    $ sudo nano 25adduser

around line 51, you will find

    db_set passwd/user-uid 999

You change 999 to 990.
-->

## Remastering

Now you are ready to remaster the system. Run **l4n_remastering.sh**

```
cd ~/git/lin4neuro-xenial
./l4n_remastering.sh
```

This will make an iso imagefile in /home/remastersys/remastersys.

You can share the iso with others.
 
## Installer for other neuroimaging software packages

I also prepared the installer for popular software packages.

* AFNI
* ANTs
* CONN 17f standalone
* FreeSurfer
* FSL
* MRtrix3
* SPM12 standalone 

these installer can be found in lin4neuro-xenial/installer


