#!/bin/bash

#####
## remember to change server_name in bootstrap-bitbucket.nginx
#####

apt-get -y install nginx

cd /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
cp bootstrap-bitbucket.nginx /etc/nginx/sites-available/bitbucket
ln -s /etc/nginx/sites-available/bitbucket /etc/nginx/sites-enabled/

service nginx restart

echo "remember to change server_name from /etc/nginx/sites-available/bitbucket"