#!/bin/bash

## BitBucket version file
# binary: atlassian-bitbucket-4.3.2-x64.bin
# source: atlassian-bitbucket-4.3.2.tar.gz
FILE=atlassian-bitbucket-4.3.2-x64.bin

CONF=varfile-bitbucket.txt

REPO=$(pwd)

## Git Large File Storage (LFS)
# source: https://confluence.atlassian.com/bitbucketserver/git-large-file-storage-lfs-794364846.html
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# java
add-apt-repository -y ppa:webupd8team/java

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

# base
apt-get -y install git curl vim screen ssh tree lynx links2 zip unzip unrar wget htop sshpass
apt-get -y install build-essential python-virtualenv python-pip python-dev 

# git
apt-get -y install git git-lfs
git lfs install

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer

# requirements (source: https://confluence.atlassian.com/bitbucketserver/supported-platforms-776640981.html)
apt-get -y install postgresql perl

cd /tmp
if [ ! -f "$FILE" ]
then
    wget https://www.atlassian.com/software/stash/downloads/binary/$FILE
    # wget https://raw.githubusercontent.com/carlessanagustin/atlassian-ALM/master/$CONF $CONF
fi
chmod +x $FILE

## Install BitBucket quiet
./$FILE -q -varfile $REPO/$CONF

service atlbitbucket start
update-rc.d atlbitbucket defaults

## Backup ddbb + home folder
# source: http://confluence.atlassian.com/display/BitbucketServer/Data+recovery+and+backups
apt-get -y install bash jq postgresql-client rsync tar

mkdir /bitbucket-backups
chown root:root /bitbucket-backups

# method 1
# cd /root
# git clone https://carlessanagustin@bitbucket.org/atlassianlabs/atlassian-bitbucket-diy-backup.git

# method 2
cd /opt/atlassian/
wget https://marketplace.atlassian.com/download/plugins/com.atlassian.stash.backup.client/version/200000200 -O bitbucket-backup-distribution-2.0.2.zip
unzip bitbucket-backup-distribution-2.0.2.zip
cd /opt/atlassian/bitbucket-backup-client-2.0.2
cp $REPO/backup-bitbucket.sh /etc/cron.daily/
chmod 750 /etc/cron.daily/backup-bitbucket.sh

## Backup logs
cp $REPO/backup-bitbucketlogs.sh /etc/cron.monthly/
chmod +x /etc/cron.monthly/backup-bitbucketlogs.sh

## prompt message
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

@/etc/crontab
25 5    * * *   root    bash /etc/cron.daily/backup-bitbucket.sh

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
