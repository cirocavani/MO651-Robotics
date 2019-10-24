#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

if [ ! -d .git ]; then
    git init
fi

git add .
git commit -m "Package setup"

../bin/julia-repl $(realpath "setup.jl")