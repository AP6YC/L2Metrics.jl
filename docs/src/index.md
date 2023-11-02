```@meta
DocTestSetup = quote
    using L2Metrics, Dates
end
```

---

These pages serve as the official documentation for the `L2Metrics.jl` Julia package.

See the [Index](@ref main-index) for the complete list of documented functions and types.

## Manual Outline

This documentation is split into the following sections:

```@contents
Pages = [
    "man/guide.md",
    "../examples/index.md",
    "man/modules.md",
    "man/contributing.md",
    "man/full-index.md",
    "man/dev-index.md",
]
Depth = 1
```

The [Package Guide](@ref package-guide) provides a tutorial to the full usage of the package, while [Examples](@ref examples) gives sample workflows for using the package.

Instructions on how to contribute to the package are found in [Contributing](@ref), and docstrings for every element of the package is listed in the [Index](@ref main-index).
Names internal to the package are also listed under the [Developer Index](@ref dev-main-index).

## [Attribution](@id attribution)

### Authors

This package is developed and maintained by [Sasha Petrenko](https://github.com/AP6YC) with sponsorship by the [Applied Computational Intelligence Laboratory (ACIL)](https://acil.mst.edu/).

If you simply have suggestions for improvement, Sasha Petrenko (<petrenkos@mst.edu>) is the current developer and maintainer of the `PyCallJLD2` package, so please feel free to reach out with thoughts and questions.

### Funding

This research was sponsored by the Army Research Laboratory and was accomplished under Cooperative Agreement Number W911NF-22-2-0209.
The views and conclusions contained in this document are those of the authors and should not be interpreted as representing the official policies, either expressed or implied, of the Army Research Laboratory or the U.S. Government.
The U.S. Government is authorized to reproduce and distribute reprints for Government purposes notwithstanding any copyright notation herein.

## Documentation Build

This documentation was built using [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) with the following version and OS:

```@example
using L2Metrics, Dates # hide
println("L2Metrics v$(L2METRICS_VERSION) docs built $(Dates.now()) with Julia $(VERSION) on $(Sys.KERNEL)") # hide
```
