#' Get a URL given a Dryad DOI
#' 
#' To get a DOI from a Dryad Handle, use [handle2doi()]
#'
#' @export
#' @param doi (character) A Dryad dataset DOI, of the form
#' 10.5061/dryad.xxx. required
#' @param ... Curl options, passed on to [crul::HttpClient]
#' @return (character) One or more URLS for direct download of datasets
#' for the given Dryad DOI
#'
#' @examples \dontrun{
#' dryad_files(doi = '10.5061/dryad.1758')
#' dryad_files(doi = '10.5061/dryad.60699')
#' 
#' # if you have a handle, use handle2doi() to convert to a DOI
#' (doi <- handle2doi('10255/dryad.153920'))
#' (files <- dryad_files(doi))
#' (out <- dryad_fetch(files))
#' # file sizes in MB
#' vapply(out, function(x) file.info(x)[["size"]], 1) / 10^6
#' }
dryad_files <- function(doi, ...) {
  assert(doi, "character")
	stopifnot(length(doi) == 1)
  tt <- dGET(paste0("https://doi.org/", doi))
  html <- xml2::read_html(tt)
  hrefs <- xml2::xml_attr(
    xml2::xml_find_all(html, '//a[contains(@href, "bitstream")]'), "href")
  urls <- paste0("http://datadryad.org", hrefs)
  return(urls)
}

# ------
# dGET2 <- function(x, ...) {
#   cli <- crul::HttpClient$new(url = x, opts = list(...))
#   res <- cli$get()
#   res$raise_for_status()
#   res$status_code
# }

# doi="10.5061/dryad.1758"
# doi <- "10.5061/dryad.9t0n8"
# doi <- "10.5061/dryad.60699"
# tt <- dGET(paste0("https://doi.org/", doi))
# html <- xml2::read_html(tt)
# hrefs <- xml2::xml_attr(xml2::xml_find_all(html, '//a[contains(@href, "bitstream")]'), "href")
# urls <- paste0("http://datadryad.org", hrefs)
# (res <- vapply(urls, dGET2, 1))
