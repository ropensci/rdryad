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
#' @details This function name changing to `dryad_files` in the 
#' next version; both work for now
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
download_url <- function(doi, ...) {
  assert(doi, "character")
	stopifnot(length(doi) == 1)
  tt <- dGET(paste0("https://doi.org/", doi))
  html <- xml2::read_html(tt)
  hrefs <- xml2::xml_attr(
    xml2::xml_find_all(html, '//a[contains(@href, "bitstream")]'), "href")
  urls <- paste0("http://datadryad.org", hrefs)
  return(urls)
 #  mm <- paste0("http://api.datadryad.org/mn/object/doi:", doi)
	# tt <- dGET(mm, ...)
	# page <- xml2::read_xml(tt)
	# out <- xml2::xml_find_all(page, "//dcterms:hasPart", ns = xml2::xml_ns(page))
	# if (length(out) == 0) stop("No output from search", call. = FALSE)
	# files <- strextract(xml2::xml_text(out), "\\/[0-9]{1}$")
 #  mm <- paste0("http://api.datadryad.org/mn/object/doi:", doi, files)
 #  mm <- file.path(mm, "bitstream")
	# if (!length(mm) > 0) stop("No output from search", call. = FALSE)
 #  return(mm)
}

#' @export
#' @rdname download_url
`dryad_files` <- `download_url`

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

# dryad_files <- function(doi, ...) {
#   tt <- dGET(paste0("https://doi.org/", doi))
#   html <- xml2::read_html(tt)
#   hrefs <- xml2::xml_attr(
#     xml2::xml_find_all(html, '//a[contains(@href, "bitstream")]'), "href")
#   urls <- paste0("http://datadryad.org", hrefs)
#   return(urls)
# }
