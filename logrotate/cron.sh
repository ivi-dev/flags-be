#!/bin/sh

# 1. Source logrotate's configuration file if it exists
if [ -f /etc/conf.d/logrotate ]; then
	. /etc/logrotate.conf
fi

# 2. Run logrotate with the main configuration
/usr/sbin/logrotate /etc/logrotate.conf

EXITVALUE=$?

if [ $EXITVALUE != 0 ]; then
    /usr/bin/logger -t logrotate "ALERT exited abnormally with [$EXITVALUE]"
fi

exit 0
