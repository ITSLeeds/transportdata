transportdata
================

-   [1 Installation](#installation)
-   [2 Datasets](#datasets)
    -   [2.1 Origin-destination data](#origin-destination-data)
    -   [2.2 Centroid data](#centroid-data)
    -   [2.3 Route data](#route-data)
-   [3 Code of Conduct](#code-of-conduct)

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) -->

[![CRAN
status](https://www.r-pkg.org/badges/version/transportdata)](https://CRAN.R-project.org/package=transportdata)
[![R-CMD-check](https://github.com/ITSLeeds/transportdata/workflows/R-CMD-check/badge.svg)](https://github.com/ITSLeeds/transportdata/actions)
<!-- [![Codecov test coverage](https://codecov.io/gh/ITSLeeds/transportdata/branch/master/graph/badge.svg)](https://codecov.io/gh/ITSLeeds/transportdata?branch=master) -->
<!-- badges: end -->

`transportdata` is a package containing transport datasets for teaching,
methodological research and software development (e.g. for
benchmarking). The aim is for it to be for people working with transport
data what `spData`, a package used for teaching and demonstrating
spatial data methods, is for people working with spatial data. The
package will be especially useful for transport/mobility researchers
using R.

# 1 Installation

<!-- You can install the released version of transportdata from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("transportdata") -->
<!-- ``` -->

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ITSLeeds/transportdata")
```

# 2 Datasets

The datasets included in the package, and code chunks used to create
them, are outlined below. To reproduce the following code, you will need
to to have installed a number of packages. The following packages must
be loaded:

``` r
library(dplyr)
library(stplanr)
```

## 2.1 Origin-destination data

OD data is arguably the most fundamental type of data for representing
city to global transport systems. The OD dataset used for this package
represents the number of commutes between a subset of desire lines
between administrative zones in Leeds, UK. The dataset was generated as
follows:

``` r
od_data = pct::get_od()
# [1] 2402201
nrow(od_data)
od_data_leeds = od_data %>% 
  filter(la_1 == "Leeds") %>% 
  filter(la_2 == "Leeds") 
nrow(od_data_leeds)
# [1] 35463
od_leeds = od_data_leeds %>% 
  filter(all >= 50)
usethis::use_data(od_leeds, overwrite = TRUE)
```

``` r
dim(transportdata::od_leeds)
#> [1] 948  18
```

## 2.2 Centroid data

``` r
centroids = pct::get_centroids_ew()
#> 
#> ── Column specification ────────────────────────────────────────────────────────
#> cols(
#>   MSOA11CD = col_character(),
#>   MSOA11NM = col_character(),
#>   BNGEAST = col_double(),
#>   BNGNORTH = col_double(),
#>   LONGITUDE = col_double(),
#>   LATITUDE = col_double()
#> )
centroids_leeds = centroids %>% 
  filter(stringr::str_detect(string = msoa11nm, pattern = "Leeds")) %>% 
  select(geo_code = msoa11cd) %>% 
  sf::st_transform(4326)
usethis::use_data(centroids_leeds, overwrite = TRUE)
#> ✔ Setting active project to '/mnt/57982e2a-2874-4246-a6fe-115c199bc6bd/atfutures/itsleeds/transportdata'
#> ✔ Saving 'centroids_leeds' to 'data/centroids_leeds.rda'
#> ● Document your data (see 'https://r-pkgs.org/data.html')
```

``` r
dim(centroids_leeds)
#> [1] 107   2
```

## 2.3 Route data

``` r
desire_lines_leeds = od::od_to_sf(od_leeds, centroids_leeds)
routes_leeds_walk = route(l = desire_lines_leeds, route_fun = route_osrm, osrm.profile = "foot")
mapview::mapview(routes_leeds_walk)
saveRDS(routes_leeds_walk, "routes_leeds_walk.Rds")
file.size("routes_leeds_walk.Rds") / 1e6 # 1.6 mb!
rnet_leeds_walk = overline(routes_leeds_walk, "foot")
plot(rnet_leeds_walk["foot"], lwd = rnet_leeds_walk$foot / 500)
piggyback::pb_upload("routes_leeds_walk.Rds")

routes_leeds_bike = route(l = desire_lines_leeds, route_fun = route_osrm, osrm.profile = "bike")
saveRDS(routes_leeds_bike, "routes_leeds_bike.Rds")
file.size("routes_leeds_bike.Rds") / 1e6 
rnet_leeds_bike = overline(routes_leeds_bike, "bicycle")
plot(rnet_leeds_bike["bicycle"], lwd = rnet_leeds_bike$bicycle / 500)
piggyback::pb_upload("routes_leeds_bike.Rds")

routes_leeds_car = route(l = desire_lines_leeds, route_fun = route_osrm, osrm.profile = "car")
saveRDS(routes_leeds_car, "routes_leeds_car.Rds")
file.size("routes_leeds_car.Rds") / 1e6 
rnet_leeds_car = overline(routes_leeds_car, "car_driver")
plot(rnet_leeds_car["car_driver"], lwd = rnet_leeds_car$car_driver / 500)
piggyback::pb_upload("routes_leeds_car.Rds")

routes_leeds_walk = routes
```

# 3 Code of Conduct

Please note that the transportdata project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
