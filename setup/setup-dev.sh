#!/usr/bin/env bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

echo "[ DEV ] setup..."

mkdir -p .vscode

echo "{
    \"python.condaPath\": \"$CONDA_INSTDIR/bin/conda\",
    \"python.pythonPath\": \"$CONDA_INSTDIR/envs/python/bin/python\",
    \"julia.executablePath\": \"$JULIA_INSTDIR/bin/julia\",
    \"files.watcherExclude\": {
        \"**/.git/objects/**\": true,
        \"**/.git/subtree-cache/**\": true,
        \"**/software/**\": true,
        \"**/downloads/**\": true
    }
}
" > .vscode/settings.json

$CONDA_INSTDIR/bin/conda install --name python -y pylint pytest autopep8 rope

$CONDA_INSTDIR/envs/python/bin/pip install -e vrep-remote-api-python
$CONDA_INSTDIR/envs/python/bin/pip install -e vrep-robot-python

Robotics.jl/setup.sh

echo "[ DEV ] done!"
