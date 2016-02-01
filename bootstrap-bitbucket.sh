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
if [ ! -f "$FILE" ]
then
    wget https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2-x64.bin
    # https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.3.2.tar.gz
fi

chmod +x $FILE
./$FILE -q -varfile 

update-rc.d atlbitbucket defaults

cd /opt/atlassian/bitbucket/4.3.2
