"""
    L2Metrics.jl

# Description
TODO

# Authors
- Sasha Petrenko <petrenkos@mst.edu> @AP6YC
"""

"""
A module that wraps the `l2logger` and `l2metrics` Python packages.

# Imports

The following names are imported by the package as dependencies:
$(IMPORTS)

# Exports

The following names are exported and available when `using` the package:
$(EXPORTS)
"""
module L2Metrics

# -----------------------------------------------------------------------------
# DEPENDENCIES
# -----------------------------------------------------------------------------

# Full using statements
using
    DocStringExtensions

# Full import statements
import
    JSON,
    PythonCall

# Precompile concrete type methods
using PrecompileSignatures: @precompile_signatures

# -----------------------------------------------------------------------------
# VARIABLES
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# INCLUDES
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# INIT
# -----------------------------------------------------------------------------

# """
# Initialization function for the `CFAR` project.
# """
# function __init__()
#     # Run the conda setup
#     conda_setup()
# end

# -----------------------------------------------------------------------------
# EXPORTS
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# PRECOMPILE
# -----------------------------------------------------------------------------

# Precompile any concrete-type function signatures
@precompile_signatures(CFAR)

end
