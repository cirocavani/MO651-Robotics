using Pkg

pkg_dir = dirname(@__FILE__)
pkg_name = replace(basename(pkg_dir), ".jl"=>"")

if haskey(Pkg.installed(), pkg_name)
    Pkg.update()
else
    Pkg.add(PackageSpec(url=pkg_dir))
end

eval(string("import ", pkg_name))
