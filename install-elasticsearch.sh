#!/usr/bin/env bash

# Install Elasticsearch 7
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

sudo apt install -y apt-transport-https

echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

sudo apt update && sudo apt install -y elasticsearch

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

echo -e "-Xms4g\n-Xmx4g\n" | sudo tee /etc/elasticsearch/jvm.options.d/snowstorm.options
echo "xpack.security.enabled: false" | sudo tee -a /etc/elasticsearch/elasticsearch.yml

sudo systemctl start elasticsearch.service
