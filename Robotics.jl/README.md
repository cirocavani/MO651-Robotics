# Robotics in Julia

V-REP P3DX.

## Setup

Automatic install.

```sh
./setup.sh
```

Alternative, manually install.

Package setup (from Project folder).

```sh
cd Robotics.jl/
git init
git add .
git commit -m "Package setup"
cd ..
```

Install (at Project folder).

```sh
bin/julia-repl
```

(Julia)

```julia
using Pkg
pkg_dir = joinpath(pwd(), "Robotics.jl")
Pkg.add(PackageSpec(url=pkg_dir))
```

## Usage

[**V-REP P3DX Julia**](../workspace/V-REP%20P3DX/V-REP%20P3DX%20Julia.ipynb) ([NBViewer](https://nbviewer.jupyter.org/github/cirocavani/MO651-Robotics/blob/master/workspace/V-REP%20P3DX/V-REP%20P3DX%20Julia.ipynb))

Example of a differential robot P3DX running on a V-REP simulation.
