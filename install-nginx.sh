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

