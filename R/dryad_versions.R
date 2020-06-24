#' Get a dataset version by version ID
#' @export
#' @param ids (character) one or more version ids, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @details 
#' 
#' `dryad_versions()`, `dryad_versions_files()`, and `dryad_files()`
#' use async http requests, while `dryad_versions_download()`
#' does not use async
#' 
#' @examples \dontrun{
#' dryad_versions(ids = 18774)
#' dryad_versions_files(ids = 18774)
#' dryad_versions_download(ids = 18774)
#' dryad_files(ids = 57485)
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
  urls <- file.path(dr_base_apiv2(), sprintf("api/v2/versions/%s/files", ids))
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, ids)
}

#' @export
#' @rdname dryad_versions
dryad_versions_download <- function(ids, ...) {
  paths <- sprintf("api/v2/versions/%s/download", ids)
  Map(function(x, y) each_download(x, y, ...), ids, paths)
}

#' @export
#' @rdname dryad_versions
dryad_files <- function(ids, ...) {
  og_ids <- ids
  urls <- file.path(dr_base_apiv2(), v2("files", ids))
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, og_ids)
}
