#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source setup/packages.sh

echo "[ Packages ] Downloading..."

mkdir -p downloads

if [ ! -f downloads/$CONDA_PKG ]; then
    curl -k -L -o downloads/$CONDA_PKG $CONDA_URL
fi

if [ ! -f downloads/$JULIA_PKG ]; then
    curl -k -L -o downloads/$JULIA_PKG $JULIA_URL
fi

if [ ! -f downloads/$VREP_PKG ]; then
    curl -k -L -o downloads/$VREP_PKG $VREP_URL
fi

md5sum --check setup/CHECKSUM.MD5

echo "[ Packages ] done!"
