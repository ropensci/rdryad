#' Download metadata for individual Dryad id's.
#' @import OAIHarvester
#' @param id Dryad identifier, i.e. 19.
#' @param transform (logical) transform metadata to list, TRUE or FALSE.
#' @param url the base url for the function (should be left to default).
#' @return Metadata for a Dryad dataset.
#' @export
#' @examples \dontrun{
#' metadat <- download_dryadmetadata('oai:datadryad.org:10255/dryad.8820', T)
#' metadat <- download_dryadmetadata(8820, T)
#' metadat$metadata # get $identifier, $datestamp, $setSpec, or $metadata
#' metadata <- oaih_transform(metadat$metadata) # transform to a list
#' }
download_dryadmetadata <-
function(id, transform, url = "http://www.datadryad.org/oai") {
    if (is.numeric(id) == TRUE)
        id <- paste("oai:datadryad.org:10255/dryad.", id, sep = "")
    oaih_get_record(url, id, prefix = "oai_dc", transform = transform)
}
