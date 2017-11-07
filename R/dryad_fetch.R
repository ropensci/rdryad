#' Download Dryad files
#'
#' @export
#' @param url (character) One or more Dryad URL for a dataset.
#' @param destfile (character) Destination file. If not given, we assign a
#' file name based on URL provided.
#' @param ... Further args passed on to [curl::curl_download()]
#' @return (character) path(s) to the file(s)
#' @details This function is a thin wrapper around [curl::curl_download()] to
#' get files to your machine only. We don't attempt to read/parse them
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
	assert(url, "character")
  if (is.null(destfile)) {
  	destfile <- replicate(length(url), tempfile())
  }
  stopifnot(length(url) == length(destfile))
  Map(function(a, b) {
  	curl::curl_download(a, destfile = b, ...)
  }, url, destfile)
}
