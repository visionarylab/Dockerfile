#!/bin/bash

apt-get install -y nginx
mkdir -p /usr/share/nginx/html
chown -R www-data:www-data /usr/share/nginx/html/

cat << EOF > /etc/nginx/sites-enabled/default
server {
    listen ${NGINX_PORT:=80};

    location / {
        alias /usr/share/nginx/html/;
        expires 10m;
    }
}
EOF

service nginx start
