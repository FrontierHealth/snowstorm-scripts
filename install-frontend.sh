#!/usr/bin/env bash

die() {
  echo >&2 "$@"
  exit 1
}

[ "$#" -eq 1 ] || die "Pass URI to script (e.g. ./install-frontend.sh https://a.b/c) and try again"

# Install distro-provided docker
sudo apt install -y docker.io

# Build and run snomedct browser
sudo docker run --name snowstorm-nginx -d -p 80:8081 --env API_HOST=$1 snomedinternational/snomedct-browser
