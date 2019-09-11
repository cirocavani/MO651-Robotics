#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh
source setup/packages.sh

echo "[ V-REP ] Installing..."

rm -rf $VREP_INSTDIR
mkdir -p $VREP_INSTDIR

tar Jxf downloads/$VREP_PKG -C $VREP_INSTDIR --strip-components=1

echo "[ V-REP ] done!"
