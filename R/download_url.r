#' Get a URL given a Dryad ID
#'
#' @export
#' @param doi (character) A Dryad dataset DOI, of the form
#' 10.5061/dryad.xxx
#' @param handle (character) A Dryad dataset handle, of the form
#' 10255/dryad.xxx
#' @param id Dryad identifier, i.e. '10255/dryad.19'. DEFUNCT, USE
#' \code{doi} or \code{handle} parameters
#' @param ...	Curl options, passed on to \code{\link[httr]{GET}}
#' @return A URL for dataset for the Dryad id.
#' @examples \dontrun{
#' # look up by doi
#' download_url(doi = '10.5061/dryad.9t0n8/1')
#'
#' # look up by legacy handle
#' download_url(handle = '10255/dryad.1759')
#' download_url(handle = '10255/dryad.102551')
#' }
download_url <- function(doi = NULL, handle = NULL, ...) {
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- 'id' %in% calls
  if (any(calls_vec)) {
    stop("The parameter 'id' has been removed. Use 'doi' or 'handle'",
         call. = FALSE)
  }

  stopifnot(xor(!is.null(doi), !is.null(handle)))
  if (is.null(doi)) {
    mm <- sprintf("%s/%s/%s", "http://datadryad.org/metadata/handle",
                  handle, "mets.xml")
  } else {
    mm <- file.path(paste0("http://datadryad.org/resource/doi:", doi),
                    "mets.xml")
  }
	tt <- dGET(mm, ...)
	page <- xml2::read_xml(tt)
	out <- xml2::xml_find_all(page, "//mets:FLocat", ns = xml_ns(page))
	if (length(out) == 0) stop("No output from search", call. = FALSE)
	links <- paste0("http://datadryad.org", xml2::xml_attr(out, "xlink:href", xml_ns(page)))
	if (length(links) > 0) {
	  links[grepl("sequence=1", links)][[1]]
	} else {
	  stop("No output from search", call. = FALSE)
	}
}
