#!/bin/bash

add-apt-repository -y ppa:webupd8team/java

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

apt-get -y install git curl vim screen ssh tree lynx links zip unzip htop

# python
apt-get -y install python-pip python-dev build-essential python-virtualenv

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer

cd /tmp

FILE=atlassian-jira-software-7.0.10-jira-7.0.10-x64.bin
CONF=varfile-jira.txt
if [ ! -f "$FILE" ]
then
    wget https://www.atlassian.com/software/jira/downloads/binary/$FILE
    wget https://raw.githubusercontent.com/carlessanagustin/atlassian-ALM/master/$CONF $CONF
fi

chmod +x $FILE
./$FILE -q -varfile $CONF

update-rc.d jira defaults
service jira start

apt-get -y install postgresql perl

cat << EndOfMessage
Carpetas de trabajo:
/var/atlassian/application-data/jira
/opt/atlassian/jira

Crear PostgreSQL
sudo -u postgres createuser -SDReP username
sudo -u postgres createdb -e -O username dbname

Acceder a Jira:
http://localhost:8080
EndOfMessage

