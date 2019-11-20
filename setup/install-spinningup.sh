#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ OpenAI Spinning Up ] Installing..."

$CONDA_INSTDIR/bin/conda env create --force -n spinningup -f setup/environment-spinningup.yaml

$CONDA_INSTDIR/envs/spinningup/bin/pip install --src=software -e \
    git+https://github.com/openai/spinningup.git@master#egg=spinup

PYTHON_KERNEL=$JUPYTER_DATA_DIR/kernels/spinningup

mkdir -p $PYTHON_KERNEL

echo "{
    \"display_name\": \"OpenAI Spinning Up\",
    \"language\": \"python\",
    \"argv\": [
        \"$CONDA_INSTDIR/envs/spinningup/bin/python\",
        \"-c\",
        \"from ipykernel.kernelapp import main; main()\",
        \"-f\",
        \"{connection_file}\"
     ]
}" > $PYTHON_KERNEL/kernel.json

echo "[ OpenAI Spinning Up ] done!"
