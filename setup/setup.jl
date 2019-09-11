println("Setup...\n")

using Pkg

Pkg.instantiate()

deps = [
    "IJulia",
    "DataFrames",
    "PyPlot",
    "Plots",
]

ENV["PYTHON"] = joinpath(ENV["CONDA_INSTDIR"], "envs", "python", "bin", "python")

Pkg.add(deps)

Pkg.API.precompile()

println("\nSetup done.")
