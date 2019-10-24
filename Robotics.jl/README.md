# Robotics in Julia

V-REP P3DX.

Package setup (from Project folder)

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
