#!/bin/bash

#####
## remember to change server_name in bootstrap-jenkins.nginx
#####

apt-get -y install nginx

cd /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
cp bootstrap-jenkins.nginx /etc/nginx/sites-available/jenkins 
ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/

service nginx restart

echo "remember to change server_name from /etc/nginx/sites-available/jenkins"
