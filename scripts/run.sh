#!/bin/bash

CONTAINER_NAME=flags-be

docker rm -f $CONTAINER_NAME
docker run -d --name $CONTAINER_NAME -p 3000:3000 $CONTAINER_NAME:latest
docker network connect flags $CONTAINER_NAME