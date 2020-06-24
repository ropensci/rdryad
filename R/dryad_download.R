#' @title dryad_download
#' @description Download datasets by their DOI(s)
#' @export
#' @param dois (character) one or more DOIs, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return file path for the file
#' @examples \dontrun{
#' dryad_download(dois = "10.5061/dryad.f385721n")
#' dois <- c("10.5061/dryad.f385721n", "10.5061/dryad.7ct1n", "10.5061/dryad.1g626")
#' dryad_download(dois = dois)
#' }
dryad_download <- function(dois, ...) {
  assert(dois, "character")
  rdryad_cache$mkdir()
  stats::setNames(lapply(dois, function(z, ...) {
    path <- v2(sprintf("datasets/%s/download",
      curl::curl_escape(paste0("doi:", z))))
    each_download(z, path, ...)
  }, ...), dois)
}

each_download <- function(id, path, ...) {
  zfile <- dGETwrite(dr_base_apiv2(), path,
    id, headers = list(`Accept` = "application/zip"), ...)
  extract_path <- file.path(rdryad_cache$cache_path_get(),
    sub(".zip", "", basename(zfile)))
  zip::unzip(zfile, junkpaths = TRUE, exdir = extract_path)
  list.files(extract_path, full.names = TRUE)
}
