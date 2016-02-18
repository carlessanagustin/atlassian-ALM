#!/bin/bash

#####
## remember to change server_name in bootstrap-jenkins.nginx
#####

apt-get -y install nginx

mkdir /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/jenkins.key -out /etc/nginx/ssl/jenkins.crt

cd /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
cp ./bootstrap-jenkins.nginx /etc/nginx/sites-available/jenkins 
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/

service nginx restart
update-rc.d nginx defaults

echo "remember to change server_name from /etc/nginx/sites-available/jenkins"
