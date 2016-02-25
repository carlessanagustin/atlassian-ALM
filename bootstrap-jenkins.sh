#!/bin/bash

REPO=$(pwd)

add-apt-repository -y ppa:webupd8team/java

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

# base
apt-get -y install git curl vim screen ssh tree lynx links2 zip unzip unrar wget htop

# python
apt-get -y install build-essential python-virtualenv python-pip python-dev 

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer

apt-get -y install jenkins

# $ vim /etc/default/jenkins
# HTTP_PORT=8085

service jenkins restart
update-rc.d jenkins defaults

mkdir /jenkins-backups
chown jenkins:jenkins /jenkins-backups
echo "/jenkins-backups"

mkdir -p /var/log/jenkins-audit-trail
chown jenkins:jenkins /var/log/jenkins-audit-trail
echo "/var/log/jenkins-audit-trail"

# prompt message
cat << EndOfMessage
need this?
$ vim /etc/default/jenkins
HTTP_PORT=8085

Working folder:
/var/lib/jenkins
/var/lib/jenkins/plugins

To disabled plugins:
touch /var/lib/jenkins/plugins/credentials.jpi.disabled

Acceder a Jenkins:
http://localhost:8080
EndOfMessage
