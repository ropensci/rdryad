#' Learn about the Dryad OAI-PMH service.
#' @import XML
#' @return List of information describing Dryad.
#' @export
#' @examples \dontrun{
#' identify()
#' }
identify <-function(formatted=FALSE) {
	url <- "http://www.datadryad.org/oai/request?verb=Identify"
	Dryad.info=xmlToList(url)
	if(!formatted)	{
			return(Dryad.info)
		}
}