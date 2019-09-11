#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ VS Code ] setup..."

mkdir -p .vscode

echo "{
    \"python.condaPath\": \"$CONDA_INSTDIR/bin/conda\",
    \"python.pythonPath\": \"$CONDA_INSTDIR/envs/python/bin/python\"
}
" > .vscode/settings.json

$CONDA_INSTDIR/bin/conda install --name python -y pylint pytest autopep8 rope

$CONDA_INSTDIR/envs/python/bin/pip install -e vrep-remote-api-python
$CONDA_INSTDIR/envs/python/bin/pip install -e vrep-robot-python

echo "[ VS Code ] setup done!"
