#!/bin/bash

# BitBucket version file
FILE=atlassian-bitbucket-4.3.2-x64.bin

add-apt-repository -y ppa:webupd8team/java

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

# base
apt-get -y install git curl vim screen ssh tree lynx links2 zip unzip unrar wget

# python
apt-get -y install build-essential python-virtualenv python-pip python-dev 

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer

# requirements (source: https://confluence.atlassian.com/bitbucketserver/supported-platforms-776640981.html)
apt-get -y install postgresql perl

cd /tmp

CONF=varfile-bitbucket.txt
if [ ! -f "$FILE" ]
then
    # https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2-x64.bin
    # https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2.tar.gz
    wget https://www.atlassian.com/software/stash/downloads/binary/$FILE
    wget https://raw.githubusercontent.com/carlessanagustin/atlassian-ALM/master/$CONF $CONF
fi

chmod +x $FILE
./$FILE -q -varfile $CONF

service atlbitbucket start
update-rc.d atlbitbucket defaults

# Backup requirements: DIY Backups using Bash scripts
# source: http://confluence.atlassian.com/display/BitbucketServer/Data+recovery+and+backups
apt-get -y install bash jq postgresql-client rsync tar

cd /root
git clone https://carlessanagustin@bitbucket.org/atlassianlabs/atlassian-bitbucket-diy-backup.git

cd /opt
wget https://marketplace.atlassian.com/download/plugins/com.atlassian.stash.backup.client/version/200000200
unzip bitbucket-backup-distribution-2.0.2.zip

# prompt message
cat << EndOfMessage
Carpetas de trabajo:
/var/atlassian/application-data/bitbucket
/opt/atlassian/bitbucket/4.3.2

Crear PostgreSQL
sudo -u postgres createuser -SDReP username
sudo -u postgres createdb -e -O username dbname

Acceder a BitBucket:
http://localhost:7990
EndOfMessage

###  Configuración con base de datos PostgreSQL ###
##
##  $ sudo -u postgres createuser -SDReP bitbucket
##  # CREATE ROLE bitbucket NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
##
##  $ sudo -u postgres createdb -e -O bitbucket bitbucket
##  # CREATE DATABASE bitbucket OWNER bitbucket;
##  
##  # ALTER USER bitbucket WITH PASSWORD 'ENCRYPT_bitbucket123';
