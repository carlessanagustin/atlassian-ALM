#!/bin/bash

#####
## remember to change server_name in bootstrap-bitbucket.nginx
#####

apt-get -y install nginx

mkdir /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/bitbucket.key -out /etc/nginx/ssl/bitbucket.crt

cd /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
cp ./bootstrap-bitbucket.nginx /etc/nginx/sites-available/bitbucket
ln -s /etc/nginx/sites-available/bitbucket /etc/nginx/sites-enabled/

service nginx restart
update-rc.d nginx defaults

echo "remember to change server_name from /etc/nginx/sites-available/bitbucket"