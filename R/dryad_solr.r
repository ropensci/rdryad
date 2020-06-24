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
d_solr_search <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_facet <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_group <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_highlight <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_mlt <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}

#' @param ... ignored
#' @rdname solr-defunct
#' @keywords internal
d_solr_stats <- function(..., proxy = NULL, callopts = list()) {
  .Defunct(msg = "defunct; the Dryad Solr service is no longer being updated")
}
