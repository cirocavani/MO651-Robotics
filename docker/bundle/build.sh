#!/usr/bin/env bash
set -xeu

cd $(dirname "$0")/../..

IMAGE_TAG="robotics:latest"
CONTAINER_NAME="robotics"

if [ ! -z "$(docker ps -q -a -f name=$CONTAINER_NAME$)" ]; then
    docker rm -f $CONTAINER_NAME
fi

setup/downloads.sh

docker pull ubuntu:18.04

docker build \
    -t $IMAGE_TAG \
    -f docker/bundle/Dockerfile \
    .

docker create \
    --tty \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume $(pwd):/home/robot/Robotics \
    --publish 8888:8888 \
    --publish 19997:19997 \
    $IMAGE_TAG
