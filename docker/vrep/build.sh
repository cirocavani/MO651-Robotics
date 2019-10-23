#!/usr/bin/env bash
set -xeu

cd $(dirname "$0")

PROJECT_DIR=$(realpath "../../")

IMAGE_TAG="ubuntu-vrep:18.04"
CONTAINER_NAME="vrep"

if [ ! -z "$(docker ps -q -a -f name=$CONTAINER_NAME$)" ]; then
    docker rm -f $CONTAINER_NAME
fi

docker pull ubuntu:18.04

docker build \
    -t $IMAGE_TAG \
    -f Dockerfile \
    .

docker create \
    --tty \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume $PROJECT_DIR:/home/robot/Robotics \
    --publish 19997:19997 \
    --publish 25000:25000 \
    $IMAGE_TAG
