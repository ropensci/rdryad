#' Get a URL given a Dryad ID
#'
#' @export
#' @param doi (character) A Dryad dataset DOI, of the form
#' 10.5061/dryad.xxx. required
#' @param ...	Curl options, passed on to [crul::HttpClient]
#' @return (character) One or more URLS for direct download of datasets
#' for the given Dryad DOI
#' @details This function name changing to `dryad_files` in the next version;
#' both work for now
#'
#' @examples \dontrun{
#' dryad_files(doi = '10.5061/dryad.1758')
#' dryad_files(doi = '10.5061/dryad.60699')
#' }
download_url <- function(doi, ...) {
	assert(doi, "character")
	stopifnot(length(doi) == 1)
  mm <- paste0("http://api.datadryad.org/mn/object/doi:", doi)
	tt <- dGET(mm, ...)
	page <- xml2::read_xml(tt)
	out <- xml2::xml_find_all(page, "//dcterms:hasPart", ns = xml2::xml_ns(page))
	if (length(out) == 0) stop("No output from search", call. = FALSE)
	files <- strextract(xml2::xml_text(out), "\\/[0-9]{1}$")
  mm <- paste0("http://api.datadryad.org/mn/object/doi:", doi, files)
  mm <- file.path(mm, "bitstream")
	if (!length(mm) > 0) stop("No output from search", call. = FALSE)
  return(mm)
}

#' @export
#' @rdname download_url
`dryad_files` <- `download_url`
