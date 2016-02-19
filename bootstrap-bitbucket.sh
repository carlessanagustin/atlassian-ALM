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

## Backup ddbb + home folder
# source: http://confluence.atlassian.com/display/BitbucketServer/Data+recovery+and+backups
apt-get -y install bash jq postgresql-client rsync tar

# method 1
# cd /root
# git clone https://carlessanagustin@bitbucket.org/atlassianlabs/atlassian-bitbucket-diy-backup.git

# method 2
cd /opt/atlassian/
wget https://marketplace.atlassian.com/download/plugins/com.atlassian.stash.backup.client/version/200000200 -O bitbucket-backup-distribution-2.0.2.zip
unzip bitbucket-backup-distribution-2.0.2.zip
cd /opt/atlassian/bitbucket-backup-client-2.0.2
cp ./backup-bitbucket.sh /etc/cron.daily/
chmod +x /etc/cron.daily/backup-bitbucket.sh
## for help
# java -jar bitbucket-backup-client.jar --help
# java -jar bitbucket-restore-client.jar --help

## Backup logs
mkdir /bitbucket-backups
chown atlbitbucket:atlbitbucket /bitbucket-backups
cp ./backup-bitbucketlogs.sh /etc/cron.monthly/
chmod +x /etc/cron.monthly/backup-bitbucketlogs.sh

# prompt message
cat << EndOfMessage
Carpetas de trabajo:
/var/atlassian/application-data/bitbucket
/opt/atlassian/bitbucket/4.3.2

Crear PostgreSQL
sudo -u postgres createuser -SDReP username
sudo -u postgres createdb -e -O username dbname

Carpetas de backup:
/bitbucket-backups
/etc/cron.daily/backup-bitbucket.sh
/etc/cron.monthly/backup-bitbucketlogs.sh

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
