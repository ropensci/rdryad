#' Get a URL given a Dryad ID
#'
#' @export
#' @param id Dryad identifier, i.e. '10255/dryad.19'.
#' @param ...	Curl options, passed on to \code{\link[httr]{GET}}
#' @return A URL for dataset for the Dryad id.
#' @examples \dontrun{
#' download_url(id = '10255/dryad.1759')
#' download_url(id = '10255/dryad.102551')
#' }
download_url <- function(id, ...) {
	mm <- sprintf("%s/%s/%s", "http://datadryad.org/metadata/handle/", id, "/mets.xml")
	tt <- content(GET(mm, ...), "text")
	page <- xml2::read_xml(tt)
	out <- xml2::xml_find_all(page, "//mets:FLocat", xml_ns(page)[1])
	links <- paste0("http://datadryad.org", xml2::xml_attr(out, "xlink:href", xml_ns(page)[2]))
	if (length(links) > 0) {
	  links[grepl("sequence=1", links)][[1]]
	} else {
		message("No output from search")
	}
}
