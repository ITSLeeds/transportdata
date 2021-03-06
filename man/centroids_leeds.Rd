% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{centroids_leeds}
\alias{centroids_leeds}
\title{Centroids of administrative (MSOA) zones in Leeds, UK}
\format{
A spatial (sf) data frame with 107 rows and 1 variable:
\describe{
\item{\code{geo_code}}{character geo_code of the unique zones}
}
}
\usage{
centroids_leeds
}
\description{
This dataset contains population-weighted centroids in
administrative (MSOA) zones in Leeds, UK
}
\examples{
centroids_leeds
dim(centroids_leeds)
library(sf)
plot(centroids_leeds)
}
\keyword{datasets}
