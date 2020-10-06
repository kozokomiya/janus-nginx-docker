#!/bin/bash

mkdir -p /var/www
cp -r /root/janus-gateway/html/* /var/www
sed -i -e 's/var server = gatewayCallbacks\.server;/var server = "\/janusbase\/janus";/' /var/www/janus.js

if [ "$1" = "sh" ]; then
  bash
else
  /opt/janus/bin/janus --log-file=/var/log/janus/janus.log
fi
