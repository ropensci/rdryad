#' List the sets in the Dryad metadata repository.
#'
#' Retrieve the set structure of Dryad, useful for selective harvesting
#' @import OAIHarvester
#' @inheritParams dr_listmetadataformats
#' @examples \dontrun{
#' dr_listsets()
#' }
#' @export
dr_listsets <- function(url = "http://www.datadryad.org/oai/request") 
{ 
	out <- oaih_list_sets(url, transform = FALSE)
	data.frame(
		setSpec = sapply(xpathApply(out, "//setSpec"), xmlValue),
		setName = sapply(xpathApply(out, "//setName"), xmlValue)
	)
}