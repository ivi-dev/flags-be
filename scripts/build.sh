#!/bin/bash

IMG_NAME=flags-be:latest
CONTAINER_NAME=flags-be

docker rm -f $CONTAINER_NAME
docker image rm -f $IMG_NAME
docker build -t $IMG_NAME $1