#' Download metadata for all Dryad oai's for defined time period
#'
#' This function is defunct
#'
#' @keywords internal
getalldryad_metadata <- function(...) {  # nocov start 
  .Defunct(msg = "This function is defunct. Use OAI-PMH via dr_*() functions or Solr based search via d_*() functions")
}

#' Search metadata for search terms using regex
#'
#' This function is defunct
#'
#' @keywords internal
search_dryad <- function(...) {
  .Defunct(msg = "This function is defunct. Use OAI-PMH via dr_*() functions or Solr based search via d_*() functions")
}

#' Download metadata for individual Dryad id's
#'
#' This function changed name to [dr_get_records()]
#'
#' @keywords internal
download_dryadmetadata <- function(...) {
  .Defunct(msg = "This function is defunct. Use dr_get_records()", 
    new = "dr_get_records", package = "rdryad")
}

#' Download url
#'
#' This function changed name to [dryad_files]
#'
#' @keywords internal
`download_url` <- function(...) {
  .Defunct(new = "dryad_files", package = "rdryad")
}

#' Get a Dryad DOI from a handle, and vice versa
#'
#' These functions are defunct
#' @param ... ignored
#' @rdname doi2handle-defunct
#' @keywords internal
doi2handle <- function(...) {
  .Defunct(msg = "`doi2handle()` is defunct")
}

#' @rdname doi2handle-defunct
#' @keywords internal
handle2doi <- function(...) {
  .Defunct(msg = "`handle2doi()` is defunct")
}


#' Defunct OAI-PMH functions
#' @name oai-defunct
#' @details The Dryad OAI-PMH service is no longer being updated
#' See http://wiki.datadryad.org/Old:Dryad_API#OAI-PMH
#' 
#' Defunct functions:
#' 
#' - `dr_get_records`
#' - `dr_identify`
#' - `dr_list_records`
#' - `dr_list_identifiers`
#' - `dr_list_metadata_formats`
#' - `dr_list_sets`
NULL

#' Download metadata for individual Dryad id's
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_get_records <- function(...) {
  .Defunct(msg = "`dr_get_records()` is defunct")
}

#' Learn about the Dryad OAI-PMH service.
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_identify <- function(...) {
  .Defunct(msg = "`dr_identify()` is defunct")
}

#' List Dryad records
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_list_records <- function(prefix = "oai_dc", from = NULL, until = NULL, 
  set = "hdl_10255_3", token = NULL, as = "df", ...) {
  
  .Defunct(msg = "`dr_list_records()` is defunct")
}

#' Gets OAI Dryad identifiers
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_list_identifiers <- function(prefix = "oai_dc", from = NULL, until = NULL,
  set = "hdl_10255_3", token = NULL, as = "df", ...) {

  .Defunct(msg = "`dr_list_identifiers()` is defunct")
}

#' Get available Dryad metadata formats
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_list_metadata_formats <- function(...) {
  .Defunct(msg = "`dr_list_metadata_formats()` is defunct")
}

#' List the sets in the Dryad metadata repository.
#'
#' @param ... ignored
#' @rdname oai-defunct
#' @keywords internal
dr_list_sets <- function(token = NULL, as = "df", ...) {
  .Defunct(msg = "`dr_list_sets()` is defunct")
}

#' Download Dryad file metadata
#'
#' This function is defunct
#' @param ... ignored
#' @rdname dryad_metadata-defunct
#' @keywords internal
dryad_metadata <- function(doi, ...) {
  .Defunct(msg = "`dryad_metadata()` is defunct")
}

#' Get file DOIs for a Dryad package DOI
#'
#' This function is defunct
#' @param ... ignored
#' @rdname dryad_package_dois-defunct
#' @keywords internal
dryad_package_dois <- function(doi, ...) {
  .Defunct(msg = "`dryad_package_dois()` is defunct")
}

#' Download Dryad files
#'
#' This function is defunct
#' @param ... ignored
#' @rdname dryad_fetch-defunct
#' @keywords internal
dryad_fetch <- function(...) {
  .Defunct(msg = "defunct; see ?dryad for how to download files")
}

#' Defunct Solr functions
#' @name solr-defunct
#' @details The Dryad Solr service is no longer being updated
#' See http://wiki.datadryad.org/Old:Dryad_API#SOLR_search_access
#' 
#' Defunct functions:
#' 
#' - `d_solr_search`
#' - `d_solr_facet`
#' - `d_solr_group`
#' - `d_solr_highlight`
#' - `d_solr_mlt`
#' - `d_solr_stats`
NULL

#' Search the Dryad Solr endpoint
#'
#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_search <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @rdname solr-defunct
#' @keywords internal
d_solr_facet <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @rdname solr-defunct
#' @keywords internal
d_solr_group <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @rdname solr-defunct
#' @keywords internal
d_solr_highlight <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @rdname solr-defunct
#' @keywords internal
d_solr_mlt <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @rdname solr-defunct
#' @keywords internal
d_solr_stats <- function(...) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
} # nocov end
