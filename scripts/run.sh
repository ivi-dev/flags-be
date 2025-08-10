#!/bin/bash

CONTAINER_NAME=flags-be

docker rm -f $CONTAINER_NAME
docker run -d \
    --name $CONTAINER_NAME \
    -p 444:444 \
    --mount type=volume,src=flags-cert-manager-private,dst=/etc/ssl/private/flags \
    --mount type=volume,src=flags-cert-manager-public,dst=/etc/ssl/certs/flags \
    $CONTAINER_NAME:latest
docker network connect flags $CONTAINER_NAME
docker exec $CONTAINER_NAME nginx