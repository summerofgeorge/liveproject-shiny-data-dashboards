# SOURCE THIS FILE TO SET UP THE DEPENDENCIES OF THIS PROEJECT.

# Helper functions

version_at_least = function (pkg, version) {
    installed = tryCatch(packageVersion(pkg), error = function (.) package_version('0.0.0'))
    installed >= version
}

use = function (pkg, version) {
    if (! version_at_least(pkg, version)) install.packages(pkg)
}

# 1. Setup

# Require a recent-ish version of ‘renv’ at the time of writing.

use('renv', '0.13.2')

# Don’t attempt to discover dependencies automatically
# (this will fail because current ‘renv’ won’t find Bioconductor
# packages automatically)
renv::init(force = TRUE, bare = TRUE, restart = FALSE)

# 2. Package installation

renv::install('BiocManager')

options(repos = BiocManager::repositories())

renv::install('maftools', 'dplyr')

# Required because our solution in R Markdown format:
renv::install('rmarkdown')

# Cleanup

rm(use, version_at_least)

# Snapshot environment

renv::snapshot(prompt = FALSE)
