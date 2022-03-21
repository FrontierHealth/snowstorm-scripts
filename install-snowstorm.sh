#!/usr/bin/env bash

# Install Snowstorm
mkdir -p /opt/snowstorm && cd /opt/snowstorm
wget https://github.com/IHTSDO/snowstorm/releases/download/7.6.0/snowstorm-7.6.0.jar

mkdir -p /usr/local/lib/systemd/system/
echo -e "[Unit]\n" \
"Description=Snowstorm Service\n" \
"Requires=elasticsearch.service\n" \
"After=elasticsearch.service\n\n" \
"[Service]\n" \
"User=snowstorm\n" \
"Type=simple\n" \
"WorkingDirectory=/opt/snowstorm\n" \
"ExecStart=java -Xms2g -Xmx4g -jar /opt/snowstorm/snowstorm.jar --snowstorm.rest-api.readonly=true --server.servlet.contextPath=/snowstorm/\n\n" \
"[Install]\n" \
"WantedBy=multi-user.target\n" | sudo tee /usr/local/lib/systemd/system/snowstorm.service

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable snowstorm.service

# Create user and own dir
sudo useradd -G admin -M snowstorm
sudo chown -R snowstorm: /opt/snowstorm/

# Ensure that spring log file is not present. Wrong owner will cause error.
sudo rm /tmp/spring.log
