#!/usr/bin/env bash

# NGINX
sudo apt install -y nginx

# SSL certs
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo openssl req -x509 -nodes -days 365 \
    -newkey ec \
    -pkeyopt ec_paramgen_curve:prime256v1 \
    -subj "/C=US/ST=DC/L=Washington/O=Frontier/CN=sct-api.frontier.md" \
    -keyout /etc/ssl/private/nginx-selfsigned-ec.key \
    -out /etc/ssl/certs/nginx-selfsigned-ec.crt

# Configure NGINX
sudo rm /etc/nginx/sites-enabled/default
sudo curl https://raw.githubusercontent.com/FrontierHealth/snowstorm-scripts/main/nginx-snowstorm.conf -o /etc/nginx/sites-available/snowstorm
sudo ln -s /etc/nginx/sites-available/snowstorm /etc/nginx/sites-enabled/snowstorm

# Start NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

# Firewall rules
sudo ufw allow 80
sudo ufw allow 443
