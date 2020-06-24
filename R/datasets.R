#' List datasets
#' @export
#' @family dryad-datasets
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a tibble
#' @examples \dontrun{
#' (x <- dryad_datasets())
#' x$meta
#' x$links
#' x$data
#' }
dryad_datasets <- function(...) {
  tmp <- dGET(dr_base_apiv2(), v2("datasets"), headers = head_json(), ...)
  res <- v2_parse(tmp)
  parse_ds(res)
}

#' Get datasets by DOI(s)
#' @export
#' @family dryad-datasets
#' @param dois (character) one or more DOIs, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @examples \dontrun{
#' dryad_dataset(doi = "10.5061/dryad.f385721n")
#' dois <- c("10.5061/dryad.f385721n", "10.5061/dryad.7ct1n", "10.5061/dryad.1g626")
#' dryad_dataset(dois = dois)
#' }
dryad_dataset <- function(dois, ...) {
  assert(dois, "character")
  og_dois <- dois
  dois <- curl::curl_escape(paste0("doi:", dois))
  tmp <- dGETasync(urls = file.path(dr_base_apiv2(), "api/v2/datasets", dois), ...)
  parse_each(tmp, og_dois)
}

#' Get dataset versions by DOI(s)
#' @export
#' @family dryad-datasets
#' @param dois (character) one or more DOIs, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @examples \dontrun{
#' x = dryad_dataset_versions(dois = "10.5061/dryad.f385721n")
#' x
#' dois <- c("10.5061/dryad.f385721n", "10.5061/dryad.7ct1n", "10.5061/dryad.1g626")
#' dryad_dataset_versions(dois = dois)
#' }
dryad_dataset_versions <- function(dois, ...) {
  assert(dois, "character")
  og_dois <- dois
  dois <- curl::curl_escape(paste0("doi:", dois))
  urls <- file.path(dr_base_apiv2(), sprintf("api/v2/datasets/%s/versions", dois))
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, og_dois)
}

parse_each <- function(x, dois) {
  stats::setNames(lapply(x, v2_parse), dois)
}

parse_ds <- function(x) {
  links <- vapply(x$`_links`, unname, list(1))
  x$`_links` <- NULL
  list(
    meta = list(count = x$count, total = x$total),
    links = links,
    data = tibble::as_tibble(x$`_embedded`$`stash:datasets`)
  )
}
