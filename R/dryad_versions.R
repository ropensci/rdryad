#' Get a dataset version by version ID
#' @export
#' @param ids (character) one or version ids, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @examples \dontrun{
#' dryad_versions(ids = 18774)
#' dryad_versions_files(ids = 18774)
#' }
dryad_versions <- function(ids, ...) {
  og_ids <- ids
  urls <- file.path(dr_base_apiv2(), v2("versions", ids))
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, og_ids)
}

#' @export
#' @rdname dryad_versions
dryad_versions_files <- function(ids, ...) {
  # FIXME: throwing 500 errors, look into
  stop("not working yet")
  og_ids <- ids
  urls <- file.path(dr_base_apiv2(), sprintf("api/v2/versions/%s/files", ids))
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, og_ids)
}

