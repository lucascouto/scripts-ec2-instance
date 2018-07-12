#!/bin/sh
# ec2-pyrit.sh
# Preps an: Amazon Linux AMI with NVIDIA GRID GPU Driver AMI

echo "Installing the run of the mill dependencies.."
yum -y install python-devel zlib-devel openssl-devel libpcap-devel.x86_64 tmux glibc-devel  automake autoconf gcc-c++ wget vim

#install the cuda tools, and set a symlink so cuda-pyrit can find them
echo "Installing cuda SDK.."
wget https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda-repo-rhel7-9-1-local-9.1.85-1.x86_64 -O cuda-repo-rhel7-9-1-local-9.1.85-1.x86_64.rpm

rpm -i cuda-repo-rhel7-9-1-local-9.1.85-1.x86_64.rpm
yum clean all
yum -y install epel-release
yum -y install dkms 
yum -y install cuda

ln -s /opt/nvidia/cuda/ /opt/cuda


#--download scapy and pyrit
echo "Downloading scapy and pyrit.."
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install scapy==2.3.2

wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pyrit/pyrit-0.4.0.tar.gz
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pyrit/cpyrit-cuda-0.4.0.tar.gz


#--install pyrit-cuda module
echo "Installing pyrit, pyrit-cuda"
tar -zxf cpyrit-cuda-0.4.0.tar.gz
cd cpyrit-cuda-0.4.0
yum -y install clang

echo "Open 'setup.py' file and change '--host-compilation C' for '-ccbin clang'"
echo "Then press enter"
read a

# change "--host-compilation C" for "-ccbin clang" on setup.py
python ./setup.py  install
cd ..


#--install pyrit
tar -zxf ./pyrit-0.4.0.tar.gz
cd pyrit-0.4.0
python ./setup.py  install
cd ..

echo "--All done--"
echo "  press enter to run benchmark."
read a
pyrit benchmark
