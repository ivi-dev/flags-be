FROM node:20.19-alpine3.21

ENV NODE_ENV=production \ 
    APP_HOME=/opt/bin/flags-be

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . .
RUN npm install

CMD ["node", "index.js"]