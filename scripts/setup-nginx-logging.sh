#!/bin/sh

# ================================================
# Create the nginx logging-related files and 
# directories.
# ================================================

NGINX_LOGS_ROOT=/var/log/nginx

ERROR_LOG_FILENAME="error.log"
ERROR_LOG_DIR_PATH=$NGINX_LOGS_ROOT/error
ERROR_LOG_FILE_PATH=$ERROR_LOG_DIR_PATH/$ERROR_LOG_FILENAME

ACCESS_LOG_FILENAME="access.log"
ACCESS_LOG_DIR_PATH=$NGINX_LOGS_ROOT/access
ACCESS_LOG_FILE_PATH=$ACCESS_LOG_DIR_PATH/$ACCESS_LOG_FILENAME

LOGS_OWNER="nginx"


# 1. Create the log DIRECTORIES if they don't exist
#
#  1.1. Create the error log directory
if [ ! -d $ERROR_LOG_DIR_PATH ]; then
    mkdir -p $ERROR_LOG_DIR_PATH
    chown $LOGS_OWNER $ERROR_LOG_DIR_PATH
    chmod 700 $ERROR_LOG_DIR_PATH
fi
#  1.2. Create the access log directory
if [ ! -d $ACCESS_LOG_DIR_PATH ]; then
    mkdir -p $ACCESS_LOG_DIR_PATH
    chown $LOGS_OWNER $ACCESS_LOG_DIR_PATH
    chmod 700 $ACCESS_LOG_DIR_PATH
fi


# 2. Create an error and access log FILES if they don't exist
#
#  2.1. Create the error log file
if [ ! -f $ERROR_LOG_FILE_PATH ]; then
    touch $ERROR_LOG_FILE_PATH
    chown $LOGS_OWNER $ERROR_LOG_FILE_PATH
    chmod 700 $ERROR_LOG_FILE_PATH
fi
#  2.2. Create the access log file
if [ ! -f $ACCESS_LOG_FILE_PATH ]; then
    touch $ACCESS_LOG_FILE_PATH
    chown $LOGS_OWNER $ACCESS_LOG_FILE_PATH
    chmod 700 $ACCESS_LOG_FILE_PATH
fi