#' Download Dryad files
#'
#' @export
#' @param url Dryad URL for a dataset.
#' @param destfile Destination file. If not given, we assign a file name based
#' on URL provided.
#' @param ... Further args passed on to [curl::curl_download()]
#' @return A path to the file
#' @details This function is a thin wrapper around download.file to get files
#' to your machine only. We don't attempt to read/parse them in to R.
#' @examples \dontrun{
#' # Single file
#' x <- dryad_files('10.5061/dryad.1758')
#'
#' ## without specifying a destination file
#' dryad_fetch(url = x)
#'
#' ## specify a destination file
#' dryad_fetch(url = x, (f <- tempfile(fileext = ".csv")))
#'
#' # Many files
#' x <- dryad_files(doi = '10.5061/dryad.60699')
#' res <- dryad_fetch(x)
#' head(read.delim(res[[1]], sep = ";"))
#' }
dryad_fetch <- function(url, destfile = NULL, ...) {
  if (is.null(destfile)) {
  	destfile <- replicate(length(url), tempfile())
  }
  stopifnot(length(url) == length(destfile))
  Map(function(a, b) {
  	curl::curl_download(a, destfile = b, ...)
  }, url, destfile)
}
