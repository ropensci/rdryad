#' Download metadata for individual Dryad id's.
#'
#' @export
#' @param id Dryad identifier, i.e. oai:datadryad.org:10255/dryad.8820
#' @param url the base url for the function (should be left to default).
#' @return Metadata for a Dryad dataset.
#' @examples \dontrun{
#' dr_get_records(ids = 'oai:datadryad.org:10255/dryad.8820')
#' }
dr_get_records <- function(ids, prefix = "oai_dc", as = "df", ...) {
  oai::get_records(ids, prefix = prefix, url = dr_base_oai(), as = as)
}
