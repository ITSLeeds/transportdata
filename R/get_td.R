#' Get transport data
#'
#' @param file_name The name of the file to download, with or without extension
#' @param base_url Where to download the data from? The `transportdata` repo
#'   by default
#' @param full_url The full URL of the file to download. Usually not needed.
#' @param download Should the file be downloaded to disk? `FALSE`
#'   by default unless the file is not an `Rds` file.
#' @export
#' @examples
#' # piggyback::pb_download_url("routes_leeds_foot.Rds")
#' library(sf)
#' rlw = get_td(file_name = "routes_leeds_foot")
get_td = function(
  file_name,
  base_url = "https://github.com/ITSLeeds/transportdata/releases/download/0.1/",
  full_url = NULL,
  download = !grepl(pattern = "\\.Rds", x = add_extension(file_name))
  ) {
  if(is.null(full_url)) {
    full_url = paste0(base_url, add_extension(file_name))
  }
  if(download) {
    message("Downloading the file")
    utils::download.file(url = full_url, destfile = file_name)
  } else {
    message("Reading in the file from ", full_url)
    return(readRDS(url(full_url)))
  }
  # } else {
  #   message("Nothing happened with this url ", base_url)
  # }
}

add_extension = function(x) {
  if(!grepl(pattern = "\\.", x = x)) {
    x = paste0(x, ".Rds")
  }
  x
}
