<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyWaste

<!-- badges: start -->
<!-- badges: end -->

## Overview

**tidyWaste** is a meta-package that installs and loads the *tidyWaste*
family of packages for environmental analysis in waste-management
operations. Loading it with a single `library(tidyWaste)` attaches all the
core member packages:

- [**hydroSense**](https://github.com/vorpalvorpal/hydroSense) — detecting
  and assessing landfill-leachate impacts on freshwater quality:
  end-member mixing analysis (leachate-mixing fraction), Bayesian
  imputation of below-detection analytes, and species-sensitivity-distribution
  toxicity assessment (PAF / msPAF).
- [**meteoHazard**](https://github.com/vorpalvorpal/meteoHazard) — turning
  meteorological data into management-relevant hazard predictions: Thermal
  Work Limit (TWL) heat-stress, plus odour-dispersion, wind-blown-litter
  and dust predictors.

## Installation

You can install the development version of tidyWaste from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("vorpalvorpal/tidyWaste")
```

This also installs the member packages from their respective repositories.

## Usage

``` r
library(tidyWaste)
#> ── Attaching tidyWaste 0.0.0.9000 ──────────────────────────────────
#> ✔ hydroSense   0.2.0     ✔ meteoHazard   0.1.0
```

`library(tidyWaste)` will load the core packages and make them available in
your current R session. To see which packages are part of the family:

``` r
tidyWaste_packages()
#> [1] "tidyWaste"   "hydroSense"  "meteoHazard"
```
