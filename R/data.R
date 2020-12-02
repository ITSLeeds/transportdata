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
#' @details DETAILS
#' @examples
#' od_leeds_50
#' dim(od_leeds_50)
#' hist(od_leeds_50$all)
#' hist(od_leeds_50$foot)
#' hist(od_leeds_50$bicycle)
"od_leeds_50"