#' Download metadata for individual Dryad id's.
#'
#' @export
#' @param id Dryad identifier, i.e. 19.
#' @param transform (logical) transform metadata to list, TRUE or FALSE.
#' @param url the base url for the function (should be left to default).
#' @return Metadata for a Dryad dataset.
#' @examples \dontrun{
#' metadat <- dr_get_records(ids = 'oai:datadryad.org:10255/dryad.8820')
#' metadat <- dr_get_records(8820, T)
#' metadat$metadata # get $identifier, $datestamp, $setSpec, or $metadata
#' metadata <- oaih_transform(metadat$metadata) # transform to a list
#' }
dr_get_records <- function(ids, prefix = "oai_dc", as = "df", ...) {
  # if (is.numeric(id) == TRUE) {
  #   id <- paste("oai:datadryad.org:10255/dryad.", id, sep = "")
  # }
  oai::get_records(ids, prefix = prefix, url = dr_base_oai(), as = as)
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"
