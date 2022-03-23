#!/usr/bin/env bash

# Install Snowstorm
mkdir -p /opt/snowstorm && cd /opt/snowstorm
curl -s https://api.github.com/repos/IHTSDO/snowstorm/releases/latest \
  | grep "browser_download_url.*\.jar" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -q -i - -O snowstorm.jar

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

# Ensure that spring log is owned by snowstorm. Wrong owner will cause error.
sudo touch /tmp/spring.log && sudo chown snowstorm:admin /tmp/spring.log
