#!/bin/bash

NGINX_LOGS_ROOT=/var/log/nginx

# 1. Create the log directories
mkdir -p -m 766 $NGINX_LOGS_ROOT/error $NGINX_LOGS_ROOT/access

# 2. Create an error log file
touch $NGINX_LOGS_ROOT/error/error.log

# 3. Create an access log file
touch $NGINX_LOGS_ROOT/access/access.log
