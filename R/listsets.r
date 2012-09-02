#' List the sets in the Dryad metadata repository.
#'
#' Retrieve the set structure of Dryad, useful for selective harvesting
#' @import OAIHarvester
#' @inheritParams listmetadataformats
#' @examples \dontrun{
#' listsets()
#' }
#' @export
listsets <- function(transform = TRUE,
  url = "http://www.datadryad.org/oai/request") 
{ 
	oaih_list_sets(url, transform = transform)
}