#' Get datasets download by DOI(s)
#' @export
#' @param dois (character) one DOI, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @examples \dontrun{
#' dryad_download(doi = "10.5061/dryad.f385721n")
#' z = dryad_download(doi = "10.5061/dryad.7ct1n", verbose = TRUE)
#' dois <- c("10.5061/dryad.f385721n", "10.5061/dryad.7ct1n", "10.5061/dryad.1g626")
#' dryad_download(dois = dois)
#' }
dryad_download <- function(doi, ...) {
  # FIXME: seems to go into endless redirects
  stop("not working yet")
  doi <- curl::curl_escape(paste0("doi:", doi))
  tmp <- dGET(dr_base_apiv2(), v2(sprintf("datasets/%s/download", doi)),
    headers = list(`Accept` = "application/zip"), ...)
  tmp
}
