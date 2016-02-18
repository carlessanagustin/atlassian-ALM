#!/bin/bash

apt-get -y install nginx

cd /etc/nginx/sites-available
rm default ../sites-enabled/default

cat >/etc/nginx/sites-available/bitbucket <<EOL
server {
	listen          443;
	server_name     your.domain.com;
	
	ssl                  	on;
	ssl_certificate      	/etc/nginx/ssl/nginx.crt;
	ssl_certificate_key  	/etc/nginx/ssl/nginx.key;
	ssl_session_timeout  	5m;
	ssl_protocols  			TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers  			HIGH:!aNULL:!MD5;
	ssl_prefer_server_ciphers   on;
	
	# Optional optimisation - please refer to http://nginx.org/en/docs/http/configuring_https_servers.html
	# ssl_session_cache   shared:SSL:10m;
#	location /bitbucket {
	location / {
#		proxy_pass 			http://localhost:7990/bitbucket;
		proxy_pass 			http://localhost:7990/;
		proxy_set_header 	X-Forwarded-Host $host;
		proxy_set_header 	X-Forwarded-Server $host;
		proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header    X-Real-IP $remote_addr;
		proxy_redirect 		off;
	}
}
EOL

ln -s /etc/nginx/sites-available/bitbucket /etc/nginx/sites-enabled/

service nginx restart
