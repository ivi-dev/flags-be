#!/bin/bash

# 1. Update apk and install prerequisites
apk update && apk add openssl curl ca-certificates

# 2. Setup the apk repo for stable nginx packages
printf "%s%s%s%s\n" \
    "@nginx " \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories

# 3. Import an official nginx signing key for verifying the packages' authenticity
curl -o /etc/apk/keys/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub

# 4. Install nginx
apk add nginx@nginx
