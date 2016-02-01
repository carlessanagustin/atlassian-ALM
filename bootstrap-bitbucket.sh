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

# requirements (source: https://confluence.atlassian.com/bitbucketserver/supported-platforms-776640981.html)
apt-get -y install postgresql perl

cd /tmp

FILE=atlassian-bitbucket-4.3.2-x64.bin
CONF=varfile-bitbucket.txt
if [ ! -f "$FILE" ]
then
    wget https://www.atlassian.com/software/stash/downloads/binary/$FILE
    # https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2-x64.bin
    # https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2.tar.gz
    wget https://raw.githubusercontent.com/carlessanagustin/atlassian-ALM/master/$CONF $CONF
fi

chmod +x $FILE
./$FILE -q -varfile varfile-bitbucket.txt

update-rc.d atlbitbucket defaults
service atlbitbucket start

ls /var/atlassian/application-data/bitbucket
ls /opt/atlassian/bitbucket/4.3.2

###  final steps ###
##  su postgres
##
##  createuser -SDReP bitbucket
##  # CREATE ROLE bitbucket NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
##  # CREATE ROLE bitbucket PASSWORD '...............' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
##
##  createdb -e -O bitbucket bitbucket
##  # CREATE DATABASE bitbucket OWNER bitbucket;
##  
##  # ALTER USER bitbucket WITH PASSWORD 'bitbucket123';





