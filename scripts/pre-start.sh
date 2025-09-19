#!/bin/sh

# ================================================
# Start nginx, rotate its logs and then start 
# the app's Node.js process.
# ================================================

nginx
rm /var/log/nginx/*.log
logrotate /etc/logrotate.conf