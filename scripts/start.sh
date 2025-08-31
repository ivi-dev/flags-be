#!/bin/sh

nginx
rm /var/log/nginx/error.log
logrotate /etc/logrotate.conf
node index.js
