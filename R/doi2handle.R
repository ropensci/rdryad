#' Get a Dryad DOI from a handle, and vice versa
#'
#' @export
#' @param x (character) A Dryad dataset DOI or handle. required
#' @param ... Curl options, passed on to [crul::HttpClient]
#' @return (character) a DOI or handle
#'
#' @examples \dontrun{
#' doi2handle('10.5061/dryad.c0765')
#' handle2doi('10255/dryad.153920')
#' doi2handle('10.5061/dryad.c0765')
#' }
doi2handle <- function(x, ...) {
	assert(x, "character")
	mm <- paste0("http://datadryad.org/resource/doi:", x)
	tt <- dGET(mm, ...)
	page <- xml2::read_html(tt)
	dc_id <- xml2::xml_find_first(page,
		"//meta[@name = \"DC.identifier\" and contains(@content, 'handle')]")
	if (length(dc_id) == 0) stop("no handle found")
	hand <- xml2::xml_attr(dc_id, "content")
	if (length(hand) == 0) stop("no handle found")
	sub("http://hdl.handle.net/", "", hand)
}

#' @export
#' @rdname doi2handle
handle2doi <- function(x, ...) {
	assert(x, "character")
	mm <- file.path("http://datadryad.org/handle", x)
	tt <- dGET(mm, ...)
	page <- xml2::read_html(tt)
	dc_id <- xml2::xml_find_first(page,
		"//meta[@name = \"DC.identifier\" and contains(@content, 'doi')]")
	if (length(dc_id) == 0) stop("no DOI found")
	doi <- xml2::xml_attr(dc_id, "content")
	if (length(doi) == 0) stop("no DOI found")
	sub("doi:", "", doi)
}
