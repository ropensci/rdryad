#' Get a URL given a Dryad ID
#'
#' @export
#' @param id Dryad identifier, i.e. '10255/dryad.19'.
#' @param ...	Curl options, passed on to \code{\link[httr]{GET}}
#' @return A URL for dataset for the Dryad id.
#' @examples \dontrun{
#' download_url(id = '10255/dryad.1759')
#' }
download_url <- function(id, ...) {
	mm <- sprintf("%s/%s/%s", "http://datadryad.org/metadata/handle/", id, "/mets.xml")
	tt <- content(GET(mm), "text")
	page <- xml2::read_xml(tt)
	out <- xml2::xml_find_all(page, "//mets:FLocat", xml_ns(page)[1])
	xml2::xml_attr(out, "xlink:href")

	# tt <- getURLContent(mm, curl = curl)
	page <- XML::xmlParse(tt)
	# The issue is here
	out <- xpathApply(page, "//mets:FLocat", function(x) {
		link <- xmlAttrs(x, "xlink:href")
		bitstream <- link["xlink:href"]
		sprintf("%s/%s", "http://datadryad.org", bitstream)
	})
	if (length(out) > 0) {
		out[grepl("sequence=1", out)][[1]]
	} else {
		message("No output from search")
	}
}
