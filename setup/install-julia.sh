#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh
source setup/packages.sh

echo "[ Julia ] Installing..."

rm -rf $JULIA_INSTDIR
rm -rf $JULIA_DEPOT_PATH
rm -f Project.toml Manifest.toml
mkdir -p $JULIA_INSTDIR

tar zxf downloads/$JULIA_PKG -C $JULIA_INSTDIR --strip-components=1

$JULIA_INSTDIR/bin/julia setup/setup.jl

echo "[ Julia ] done!"
