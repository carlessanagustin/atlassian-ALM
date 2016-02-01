#!/bin/bash

add-apt-repository -y ppa:webupd8team/java

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

apt-get -y install git curl vim screen ssh tree lynx links zip unzip

# python
apt-get -y install python-pip python-dev build-essential python-virtualenv

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer


apt-get -y install doxygen