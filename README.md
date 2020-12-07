transportdata
================

-   [1 Installation](#installation)
-   [2 Datasets](#datasets)
    -   [2.1 Origin-destination data](#origin-destination-data)
    -   [2.2 Zone data](#zone-data)
    -   [2.3 Centroid data](#centroid-data)
    -   [2.4 Route data](#route-data)
    -   [2.5 Air quality data](#air-quality-data)
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
them, are outlined below. After you have installed the package, the
datasets should be available.

``` r
library(transportdata)
```

To reproduce the following code, you will need to to have installed a
number of packages. The following packages must also be loaded:

``` r
library(sf)
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

## 2.2 Zone data

``` r
z = pct::get_pct_zones("west-yorkshire", geography = "msoa")
zones_leeds = z %>% 
  filter(lad_name == "Leeds") %>% 
  select(geo_code:taxi_other, dutch_slc)
usethis::use_data(zones_leeds)
```

``` r
dim(zones_leeds)
#> [1] 107  15
names(zones_leeds)
#>  [1] "geo_code"      "geo_name"      "lad11cd"       "lad_name"     
#>  [5] "all"           "bicycle"       "foot"          "car_driver"   
#>  [9] "car_passenger" "motorbike"     "train_tube"    "bus"          
#> [13] "taxi_other"    "dutch_slc"     "geometry"
plot(zones_leeds[5:14])
#> Warning: plotting the first 9 out of 10 attributes; use max.plot = 10 to plot
#> all
```

<img src="man/figures/README-zones-1.png" width="100%" />

## 2.3 Centroid data

``` r
dim(centroids_leeds)
#> [1] 107   2
names(centroids_leeds)
#> [1] "geo_code" "geometry"
plot(centroids_leeds)
```

<img src="man/figures/README-centroids-1.png" width="100%" />

## 2.4 Route data

The route data was generated as follows:

``` r
od_interzonal = od_leeds %>% 
  filter(geo_code1 != geo_code2)
desire_lines_leeds = od::od_to_sf(od_interzonal, centroids_leeds)
#> 0 origins with no match in zone ids
#> 0 destinations with no match in zone ids
#>  points not in od data removed.
desire_lines_leeds_10 = desire_lines_leeds %>% 
  top_n(n = 10, wt = all)
plot(desire_lines_leeds_10)
#> Warning: plotting the first 10 out of 18 attributes; use max.plot = 18 to plot
#> all
```

<img src="man/figures/README-desire-1.png" width="100%" />

``` r
# get route data for top 10 routes for different modes
routes_leeds_foot_10 = route(l = desire_lines_leeds_10, route_fun = route_osrm, osrm.profile = "foot")
routes_leeds_bike_10 = route(l = desire_lines_leeds_10, route_fun = route_osrm, osrm.profile = "bike")
routes_leeds_car_10 = route(l = desire_lines_leeds_10, route_fun = route_osrm, osrm.profile = "car")
```

``` r
plot(routes_leeds_foot_10$geometry, lwd = 6, col = "green")
plot(routes_leeds_bike_10$geometry, lwd = 4, col = "blue", add = TRUE)
plot(routes_leeds_car_10$geometry, lwd = 2, col = "red", add = TRUE)
```

<img src="man/figures/README-routes-10-1.png" width="100%" />

You can get the full routes as follows:

``` r
routes_leeds_foot = get_td("routes_leeds_foot")
#> Reading in the file from https://github.com/ITSLeeds/transportdata/releases/download/0.1/routes_leeds_foot.Rds
routes_leeds_bike = get_td("routes_leeds_bike")
#> Reading in the file from https://github.com/ITSLeeds/transportdata/releases/download/0.1/routes_leeds_bike.Rds
routes_leeds_car = get_td("routes_leeds_car")
#> Reading in the file from https://github.com/ITSLeeds/transportdata/releases/download/0.1/routes_leeds_car.Rds
```

``` r
rnet_leeds_foot = overline(routes_leeds_foot, "foot")
plot(rnet_leeds_foot["foot"], lwd = rnet_leeds_foot$foot / 500)
rnet_leeds_bike = overline(routes_leeds_bike, "bicycle")
plot(rnet_leeds_bike["bicycle"], lwd = rnet_leeds_bike$bicycle / 500)
rnet_leeds_car = overline(routes_leeds_car, "car_driver")
plot(rnet_leeds_car["car_driver"], lwd = rnet_leeds_car$car_driver / 500)
```

<img src="man/figures/README-routes-rnet-1.png" width="33%" /><img src="man/figures/README-routes-rnet-2.png" width="33%" /><img src="man/figures/README-routes-rnet-3.png" width="33%" />

## 2.5 Air quality data

Data on air quality was obtained as follows:

``` r
install.packages("openair")
library(openair)
all_sites = importMeta()
# View(all_sites)
all_sites_sf = sf::st_as_sf(all_sites, coords = c("longitude", "latitude"), crs = 4326)
leeds_sites = all_sites_sf[zones_leeds, ]
headingley = importAURN(site = "LED6", year = 2017:2019, pollutant = c("nox", "no2"))
summary(headingley)
table(headingley$site)
air_quality_leeds_raw = importAURN(site = leeds_sites$code, year = 2017:2019, pollutant = c("nox", "no2"))
air_quality_leeds = right_join(leeds_sites, air_quality_leeds_raw)
usethis::use_data(air_quality_leeds, overwrite = TRUE)
```

``` r
library(openair)
dim(air_quality_leeds)
#> [1] 52560     7
names(air_quality_leeds)
#> [1] "site"      "code"      "site_type" "geometry"  "date"      "nox"      
#> [7] "no2"
table(air_quality_leeds$site)
#> 
#>              Leeds Centre Leeds Headingley Kerbside 
#>                     26280                     26280
air_quality_leeds %>% 
  sf::st_drop_geometry() %>% 
  filter(site == "Leeds Centre") %>% 
  TheilSen(pollutant = "no2", ylab = "NO2 (ug/m3)", deseason = TRUE, main = "Leeds Centre")
#> [1] "Taking bootstrap samples. Please wait."
air_quality_leeds %>% 
  sf::st_drop_geometry() %>% 
  filter(site == "Leeds Headingley Kerbside") %>% 
  TheilSen(pollutant = "no2", ylab = "NO2 (ug/m3)", deseason = TRUE, main = "Leeds Headingley Kerbside")
#> [1] "Taking bootstrap samples. Please wait."
```

<img src="man/figures/README-airq-1.png" width="49%" /><img src="man/figures/README-airq-2.png" width="49%" />

``` r
air_quality_summary = air_quality_leeds %>% 
  group_by(site, year = substring(date, 1, 4)) %>% 
  summarise(
    mean_no2 = mean(no2, na.rm = TRUE),
    mean_nox = mean(nox, na.rm = TRUE)
    )
#> `summarise()` regrouping output by 'site' (override with `.groups` argument)
library(tmap)
tm_shape(air_quality_summary, bbox = tmaptools::bb(air_quality_leeds, 1.5)) +
  tm_dots("mean_nox", size = 5) +
  tm_facets(by = "year", nrow = 1) +
  tm_shape(routes_leeds_foot_10) +
  tm_lines() 
```

<img src="man/figures/README-airqmap-1.png" width="100%" />

# 3 Code of Conduct

Please note that the transportdata project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
