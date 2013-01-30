#' Download URL for a Dryad id.
#' @import RCurl XML stringr
#' @param id Dryad identifier, i.e. '10255/dryad.19'.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'    the returned value in here (avoids unnecessary footprint)
#' @return A URL for dataset for the Dryad id.
#' @export
#' @examples \dontrun{
#' download_url(id='10255/dryad.1759')
#' }
download_url <- function(id, curl = getCurlHandle()) 
{
	mets_metadata <- sprintf("%s/%s/%s", "http://datadryad.org/metadata/handle/",
													 id, "/mets.xml")
	tt <- getURLContent(mets_metadata, curl = curl)
	page <- xmlParse(tt)
	# The issue is here
	out <- xpathApply(page, "//mets:FLocat", function(x) {
		link <- xmlAttrs(x, "xlink:href")
		bitstream <- link["xlink:href"]
		sprintf("%s/%s", "http://datadryad.org", bitstream)
	})
	if(length(out)>0) {
		out[lapply(out, str_detect, pattern = "sequence=1") == "TRUE"][[1]]
	} else {
		message("No output from search")
	}
}