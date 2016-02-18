#!/bin/bash

apt-get -y install nginx

cd /etc/nginx/sites-available
rm default ../sites-enabled/default

cat >/etc/nginx/sites-available/jenkins <<EOL
upstream app_server {
    server 127.0.0.1:8080 fail_timeout=0;
}
server {
    listen 80;
    listen [::]:80 default ipv6only=on;
    server_name ci.yourcompany.com;

    location / {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        
        proxy_redirect off;
        
        proxy_pass http://app_server;
        
        proxy_read_timeout  90;
    }
}
EOL

ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
service nginx restart

