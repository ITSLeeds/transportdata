transportdata
================

-   [transportdata](#transportdata)
    -   [0.1 Installation](#installation)
    -   [0.2 Datasets](#datasets)
    -   [0.3 Code of Conduct](#code-of-conduct)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# transportdata

<!-- badges: start -->
<!-- [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) -->

[![CRAN
status](https://www.r-pkg.org/badges/version/transportdata)](https://CRAN.R-project.org/package=transportdata)
[![R-CMD-check](https://github.com/ITSLeeds/transportdata/workflows/R-CMD-check/badge.svg)](https://github.com/ITSLeeds/transportdata/actions)
[![Codecov test
coverage](https://codecov.io/gh/ITSLeeds/transportdata/branch/master/graph/badge.svg)](https://codecov.io/gh/ITSLeeds/transportdata?branch=master)
<!-- badges: end -->

The goal of transportdata is to provide example transport datasets for
teaching, research and software development.

## 0.1 Installation

<!-- You can install the released version of transportdata from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("transportdata") -->
<!-- ``` -->

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ITSLeeds/transportdata")
```

## 0.2 Datasets

The datasets included to date are outlined below:

``` r
dim(transportdata::od_leeds_50)
#> [1] 948  18
```

## 0.3 Code of Conduct

Please note that the transportdata project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
