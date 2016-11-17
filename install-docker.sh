#!/bin/sh

if [ $(id -u) != "0" ]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# echo on
set -x

apt-get update
apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

. /etc/os-release
echo "deb https://apt.dockerproject.org/repo $ID-$VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update

apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual

apt-get -y install docker-engine

service docker start

groupadd docker
usermod -aG docker $SUDO_USER
