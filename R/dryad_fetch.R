#' Download Dryad files
#'
#' @export
#' @param url (character) One or more Dryad URL for a dataset
#' @param destfile (character) Destination file. If not given, we assign a
#' file name based on URL provided.
#' @param try_file_names (logical) try to parse file names out of the 
#' URLs. Default: `FALSE`
#' @param ... Further args passed on to [curl::curl_download()]
#' @return named (list) with path(s) to the file(s) - list names 
#' are the urls passed into the `url` parameter
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
#' dryad_fetch(url = x[1], (f <- tempfile(fileext = ".csv")))
#' 
#' ## use try_file_names - we try to extract file names from URLs
#' dryad_fetch(url = x, try_file_names = TRUE)
#'
#' # Many files
#' x <- dryad_files(doi = '10.5061/dryad.60699')
#' res <- dryad_fetch(x)
#' head(read.delim(res[[1]], sep = ";"))
#' }
dryad_fetch <- function(url, destfile = NULL, try_file_names = FALSE, ...) {
  assert(url, "character")
  if (is.null(destfile) && !try_file_names) {
  	destfile <- replicate(length(url), tempfile())
  }
  if (try_file_names) {
    destfile <- gsub("\\?.+", "", basename(url))
  }
  stopifnot(length(url) == length(destfile))
  Map(function(a, b) {
  	curl::curl_download(a, destfile = b, ...)
  }, url, destfile)
}
