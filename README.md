# snowstorm-scripts
Scripts for initializing a new Snowstorm server.

These files should make setup and installation of basic components quick and painless.

### install-browser.sh <API_URI>
Installs docker and builds/runs [SNOMEDCT Browser](https://github.com/IHTSDO/sct-browser-frontend)

### install-elasticsearch.sh
Installs, configures, and starts ElasticSearch 7. Enables startup daemon.

### install-nginx.sh
Installs NGINX, nginx-snowstorm.conf, and runs NGINX. Opens port 80 and 443 on firewall.

### install-snowstorm.sh
Installs latest version of [SNOMEDCT Terminology Server](https://github.com/IHTSDO/snowstorm). Enables startup daemon. Does not start Snowstorm because imports must be setup. See Snowstorm documentation for instructions.

### nginx-snowstorm.conf
NGINX config for use with install-nginx.sh
