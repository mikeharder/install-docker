#!/bin/sh

if [ $(id -u) != "0" ]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# echo on
set -x

# remove older versions
apt-get remove docker docker-engine

apt-get update
apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

apt-get install 
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get -y install docker-ce

groupadd docker
usermod -aG docker $SUDO_USER
