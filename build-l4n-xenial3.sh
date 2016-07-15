#!/bin/bash
#Lin4Neuro making script part 3
#Remastersys

#ChangeLog
#26-Jan-2016: Comment downloading remastersys
#17-Jan-2016: Merge Japanese and English version.
#28-Nov-2015: Update version of remastersys

#Installation of Remastersys
#echo "Download and install remastersys"
#wget http://www.nemotos.net/lin4neuro/build/remastersys_4.0.0-5_all.deb

sudo apt-get -y  --no-install-recommends install memtest86+ mkisofs \
	squashfs-tools casper libdebian-installer4 \
	user-setup localechooser-data cifs-utils \
	samba-common libtalloc2 libwbclient0 \
	ubiquity-frontend-debconf syslinux xresprobe \
	syslinux-common  ubiquity  bogl-bterm \
	libiw30 ubiquity-ubuntu-artwork ubiquity-casper rdate \
	ecryptfs-utils cryptsetup \
	python3-icu python3-pam archdetect-deb dpkg-repack apt-clone \
	cryptsetup-bin libecryptfs0 keyutils libnss3-1d \
	libcryptsetup4 dialog

sudo dpkg -i remastersys_4.0.0-5_all.deb

#Workaround for plymouth
sudo cp ~/lin4neuro-parts/rs-workaround/plymouth-shutdown.conf /etc/init/

#usb-creator
sudo apt-get -y install usb-creator-common usb-creator-gtk

echo "Part 3 finished! Now ready for remastering. Execute l4n_remastering.sh in lin4neuro-parts"
