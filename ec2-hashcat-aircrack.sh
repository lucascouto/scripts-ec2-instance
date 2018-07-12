#!/bin/sh
# ec2-hashcat.sh
# Preps an: Amazon Linux AMI with NVIDIA GRID GPU Driver AMI

echo "Downloading hashcat..."
wget https://hashcat.net/files/hashcat-4.1.0.7z -O hashcat.7z
yum -y install p7zip
7za x hashcat.7z
chmod a+x hashcat-4.1.0/hashcat64.bin


echo "Installing necessary dependencies for aircrack-ng..."
yum -y install libtool pkgconfig sqlite-devel autoconf automake openssl-devel libpcap-devel pcre-devel rfkill libnl3-devel gcc gcc-c++ ethtool

echo "Downloading aircrack-ng..."
wget https://github.com/aircrack-ng/aircrack-ng/archive/master.zip
unzip master.zip
clear

echo "Installing aircrack-ng..."
cd aircrack-ng-master
autoreconf -i
./configure
make
make install
cd ..
^d

echo "Finished!"

