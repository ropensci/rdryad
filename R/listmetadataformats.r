#' Learn about the Dryad metadata formats available.
#' @import XML
#' @return List of information on metadata formats.
#' @export
#' @examples \dontrun{
#' listmetadataformats()
#' }
listmetadataformats <-function() {
  url <- "http://www.datadryad.org/oai/request?verb=ListMetadataFormats"
  xmlToList(url)$ListMetadataFormats
}