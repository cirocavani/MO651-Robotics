#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "Installing..."

setup/downloads.sh
setup/install-conda.sh
setup/install-jupyter.sh
setup/install-python.sh
setup/install-julia.sh
setup/install-vrep.sh

$CONDA_INSTDIR/bin/conda clean -y --all

echo "Install done!"
