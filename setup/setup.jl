println("Setup...\n")

using Pkg

Pkg.instantiate()

deps = [
    "IJulia",
    "DataFrames",
    "CSV",
    "PyPlot",
    "Plots",
    "StatsPlots",
    "Images",
    "ImageMagick",
]

ENV["PYTHON"] = joinpath(ENV["CONDA_INSTDIR"], "envs", "python", "bin", "python")

Pkg.add(deps)

Pkg.API.precompile()

for m in deps
    eval(string("import ", m))
end

println("\nSetup done.")
