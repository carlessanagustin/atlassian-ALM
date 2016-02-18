#!/bin/bash

add-apt-repository -y ppa:webupd8team/java

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

apt-get update
#apt-get -y upgrade

locale-gen UTF-8

apt-get -y install git curl vim screen ssh tree lynx links zip unzip

# python
#apt-get -y install python-pip python-dev build-essential python-virtualenv

# java
echo "oracle-java8-installer shared/present-oracle-license-v1-1 boolean true" | debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
apt-get -y install oracle-java8-installer

apt-get -y install doxygen jenkins

# VAGRANT only
#
# $ vim /etc/default/jenkins
# HTTP_PORT=8085
# $ service jenkins restart

service jenkins restart
update-rc.d jenkins defaults

mkdir /jenkins-backups
chown jenkins:jenkins /jenkins-backups
echo "/jenkins-backups"

mkdir -p /var/log/jenkins-audit-trail
chown jenkins:jenkins /var/log/jenkins-audit-trail
echo "/var/log/jenkins-audit-trail"