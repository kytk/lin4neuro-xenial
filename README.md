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

    $ sudo apt-get install git
    $ mkdir ~/git
    $ cd ~/git
    $ git clone https://github.com/kytk/lin4neuro-xenial.git

## Install XFCE4.12

First, run **build-l4n-xenial-1.sh**.

    $ cd ~/git/lin4neuro-xenial
    $ ./build-l4n-xenial-1.sh

The script will bring a prompt as following;

    Which language do you want to build? (English/Japanese)
    1) English
    2) Japanese
    3) quit
    #? 

Choose 1 or 2 depending on your language.

Then XFCE4.12 is installed. Upon installation, the system automatically reboots.

## Customization of UI

Second, run **build-l4n-xenial-2.sh**.

    $ cd ~/git/lin4neuro-xenial
    $ ./build-l4n-xenial-2.sh

This will customize UI and install FSL and MRIConvert based on Neurodebian repository. It also adds PATH to various neuroimaging software packages.

Upon customization, the system reboots again.

## Installation of Neuroimaging software packages

Now, you must install several software packages manually.
For simplicity, I assume every software is installed under /usr/local

    $ cd ~/git/lin4neuro-xenial
    $ ./crawl.sh

will take you to various sites.

Below is the list of manually installed software packages

* 3D Slicer
* AFNI
* ANTs
* ITK-SNAP
* C3D
* Mango
* MRIcron
* MRIcroGL
* ROBEX
* Virtual MRI

## Check the software packages are installed correctly.

After installation of the software above, run build-l4n-xenial-3.sh

    $ cd ~/git/lin4neuro-xenial
    $ ./build-l4n-xenial-3.sh

This script simply tries to run software listed above.
If it is not installed correctly, you will see error messages in the terminal. Check it and correct.

<!---
## Prepare for remastering

If everything is set, run the script below.

    $ cd ~/git/lin4neuro-xenial
    $ ./build-l4n-xenial-4.sh

This will install customized Remastersys. Since remastersys stops developing, we customized the remastersys so it works for our need.

Configuration of remastersys is found in /etc/remastersys.conf

Modify the setting as you wish.

## (optional but important) Change UID in casper

If you work under VirtualBox circumstance, you need to do the following.
When you use VirtualBox Guest Additions, you need to add your username to vboxsf group. The id of vboxsf will be 999, which conflicts with uid of the user (custom) in live media. In order to avoid the conflict, change uid in casper settings.

    $ cd /usr/share/initramfs-tools/scripts/casper-bottom
    $ sudo nano 25adduser

around line 51, you will find

    db_set passwd/user-uid 999

You change 999 to 990.

## Remastering

Now you are ready to remaster the system.

    $ cd ~/git/lin4neuro-xenial
    $ ./l4n_remastering.sh

will make iso in /home/remastersys/remastersys.

You can share the iso with others.
--->

 

