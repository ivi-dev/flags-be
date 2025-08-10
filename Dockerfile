FROM node:20.19-alpine3.21


###############################################
#         Install and configure Nginx
###############################################

ENV SSL_PUBLIC=/etc/ssl/certs/flags \
    SSL_PRIVATE=/etc/ssl/private/flags

COPY scripts/*-nginx.sh /root
RUN . /root/install-nginx.sh
COPY nginx.conf /etc/nginx

###############################################
#       Install and start the Express app
###############################################

ENV NODE_ENV=production \ 
    APP_HOME=/opt/bin/flags

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . .
RUN rm -r scripts nginx.conf
RUN npm install

CMD ["node", "index.js"]