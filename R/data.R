#' @title Origin-destination data from Leeds, UK
#' @description This dataset represents movement between administrative 'MSOA'
#' zones in Leeds, UK. The data was collected in the 2011 Census and reports
#' the mode of travel to work.
#' @format A data frame with 948 rows and 18 variables:
#' \describe{
#'   \item{\code{geo_code1}}{character Origin}
#'   \item{\code{geo_code2}}{character Destination}
#'   \item{\code{all}}{double Travel (all modes)}
#'   \item{\code{from_home}}{double Ppl working from home}
#'   \item{\code{light_rail}}{double N. travelling by mode}
#'   \item{\code{train}}{double N. travelling by mode}
#'   \item{\code{bus}}{double N. travelling by mode}
#'   \item{\code{taxi}}{double N. travelling by mode}
#'   \item{\code{motorbike}}{double N. travelling by mode}
#'   \item{\code{car_driver}}{double N. travelling by mode}
#'   \item{\code{car_passenger}}{double N. travelling by mode}
#'   \item{\code{bicycle}}{double N. travelling by mode}
#'   \item{\code{foot}}{double N. travelling by mode}
#'   \item{\code{other}}{double N. travelling by mode}
#'   \item{\code{geo_name1}}{character Name of origin zone}
#'   \item{\code{geo_name2}}{character Name of destination zone}
#'   \item{\code{la_1}}{character Local authority of origin}
#'   \item{\code{la_2}}{character Local authority of destination}
#'}
#' @examples
#' dim(od_leeds)
#' b = seq(0, 2000, by = 100)
#' head(od_leeds)
#' hist(od_leeds$all, breaks = b)
#' hist(od_leeds$foot, breaks = b)
#' hist(od_leeds$bicycle, breaks = b)
"od_leeds"

#' @title Zones of administrative (MSOA) zones in Leeds, UK
#' @description This dataset contains polygons and Census travel to work data associated with
#' administrative (MSOA) zones in Leeds, UK
#' @format A spatial (sf) data frame with 107 rows and 15 variables (modes same as `od_leeds` dataset).
#' \describe{
#'   \item{\code{geo_code}}{character geo_code of the unique zones}
#'   \item{\code{dutch_slc}}{Number who cycle to work under the PCT's Go Dutch scenario}
#'}
#' @examples
#' zones_leeds
#' dim(zones_leeds)
#' library(sf)
#' plot(zones_leeds)
"zones_leeds"

#' @title Centroids of administrative (MSOA) zones in Leeds, UK
#' @description This dataset contains population-weighted centroids in
#' administrative (MSOA) zones in Leeds, UK
#' @format A spatial (sf) data frame with 107 rows and 1 variable:
#' \describe{
#'   \item{\code{geo_code}}{character geo_code of the unique zones}
#'}
#' @examples
#' centroids_leeds
#' dim(centroids_leeds)
#' library(sf)
#' plot(centroids_leeds)
"centroids_leeds"


#' @title Routes on the transport network
#' @description This dataset represents routes associated with the top 10
#'   commuter 'desire lines' in Leeds.
#' @format A data frame with 10 rows and 22 variables:
#' \describe{
#'   \item{\code{distance}}{double Distance in m according to OSRM}
#'   \item{\code{duration}}{double Duration in seconds according to OSRM}
#'   \item{\code{geometry}}{list Geometry}
#'}
#' @aliases routes_leeds_bike_10 routes_leeds_car_10
#' @examples
#' plot(routes_leeds_foot_10$geometry, lwd = 6, col = "green")
#' plot(routes_leeds_bike_10$geometry, lwd = 4, col = "blue", add = TRUE)
#' plot(routes_leeds_car_10$geometry, lwd = 2, col = "red", add = TRUE)
"routes_leeds_foot_10"

#' @title Air quality data at two points in Leeds
#' @description This dataset represents routes associated with the top 10
#'   commuter 'desire lines' in Leeds.
#' @format A data frame with 10 rows and 22 variables:
#' \describe{
#'   \item{\code{site}}{site name}
#'   \item{\code{code}}{site code}
#'   \item{\code{site_type}}{site type}
#'   \item{\code{geometry}}{list Geometry}
#'   \item{\code{date}}{date}
#'   \item{\code{nox}}{concentration of nox}
#'   \item{\code{no2}}{concentration of no2}
#'}
#' @examples
#' dim(air_quality_leeds)
#' names(air_quality_leeds)
#' table(air_quality_leeds$site)
"air_quality_leeds"
