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


# Installing NGINX
#
# apt-get -y install nginx
# 
# cd /etc/nginx/sites-available
# rm default ../sites-enabled/default
# 
# cat >/etc/nginx/sites-available/jenkins <<EOL
# upstream app_server {
#     server 127.0.0.1:8080 fail_timeout=0;
# }
# server {
#     listen 80;
#     listen [::]:80 default ipv6only=on;
#     server_name ci.yourcompany.com;
# 
#     location / {
#         proxy_set_header        Host $host;
#         proxy_set_header        X-Real-IP $remote_addr;
#         proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header        X-Forwarded-Proto $scheme;
#         
#         proxy_redirect off;
#         
#         proxy_pass http://app_server;
#         
#         proxy_read_timeout  90;
#     }
# }
# EOL
# 
# ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
# service nginx restart

