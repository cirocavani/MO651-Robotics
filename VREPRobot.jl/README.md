# V-REP P3DX Robot in Julia

Package setup (from Project folder)

```sh
cd VREPRobot.jl/
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
pkg_dir = joinpath(pwd(), "VREPRobot.jl")
Pkg.add(PackageSpec(url=pkg_dir))
```
