#!/bin/sh

nginx
rm /var/log/nginx/*.log
logrotate /etc/logrotate.conf
node index.js
