#!/bin/sh

if [ $(id -u) != "0" ]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# echo on
set -x

apt-get update
apt-get install curl \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

apt-get install apt-transport-https \
                       ca-certificates

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -

apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D

apt-get install software-properties-common
add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

apt-get update

apt-get -y install docker-engine

service docker start

groupadd docker
usermod -aG docker $SUDO_USER
