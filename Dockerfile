FROM node:24-alpine3.21


###############################################
#         Install and configure Nginx
###############################################

ENV SSL_PUBLIC=/etc/ssl/certs/flags \
    SSL_PRIVATE=/etc/ssl/private/flags

COPY scripts/*nginx*.sh /root
RUN chmod 700 /root/*.sh
RUN . /root/install-nginx.sh
COPY nginx.conf /etc/nginx
RUN mkdir -p /var/cache/nginx/flags
RUN . /root/setup-nginx-logs.sh
COPY scripts/start.sh /root

###############################################
#             Setup log rotation
###############################################

RUN apk add logrotate
COPY logrotate/main.conf /etc/logrotate.conf
COPY logrotate/nginx.conf /etc/logrotate.d/nginx
COPY logrotate/cron.sh /etc/periodic/daily/logrotate.sh

###############################################
#       Install and start the Express app
###############################################

ENV NODE_ENV=production \ 
    APP_HOME=/opt/bin/flags \
    NGINX_LOGS_ROOT=/var/log/nginx

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . .
RUN rm -r scripts nginx.conf
RUN npm install

CMD ["/bin/sh", "-c", "/root/start.sh"]