FROM node:24-alpine3.21


#########################################################
#              Install and configure Nginx
#########################################################

ENV SSL_PUBLIC=/etc/ssl/certs/flags \
    SSL_PRIVATE=/etc/ssl/private/flags \
    NGINX_CACHE_DIR=/var/log/nginx/flags

COPY scripts/*nginx*.sh scripts/pre-start.sh /root/
RUN chown root /root/*.sh && chmod 700 /root/*.sh
RUN apk update && apk add openssl curl ca-certificates
RUN printf "%s%s%s%s\n" \
           "@nginx " \
           "http://nginx.org/packages/alpine/v" \
           `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
           "/main" | \
    tee -a /etc/apk/repositories
RUN curl -o /etc/apk/keys/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub
RUN apk add nginx@nginx
COPY nginx.conf /etc/nginx
RUN mkdir -p $NGINX_CACHE_DIR
RUN chown -R nginx $NGINX_CACHE_DIR
RUN /root/setup-nginx-logging.sh


#########################################################
#                  Setup log rotation
#########################################################

RUN apk add logrotate
COPY logrotate/main.conf /etc/logrotate.conf
COPY logrotate/nginx.conf /etc/logrotate.d/nginx
COPY logrotate/cron.sh /etc/periodic/daily/logrotate.sh


#########################################################
#           Install and start the Express app
#########################################################

ENV NODE_ENV=production \
    APP_HOME=/opt/bin/flags \
    USER="flags-backend"

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . .
RUN rm -r logrotate scripts nginx.conf
RUN npm install
RUN adduser -D -u 1001 -H -s /sbin/nologin $USER
RUN chown -R $USER $APP_HOME
RUN chmod -R 700 $APP_HOME
RUN /root/pre-start.sh

USER $USER

ENTRYPOINT [ "node" ]
CMD [ "index.js" ]