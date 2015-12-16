#' Learn about the Dryad OAI-PMH service.
#'
#' @export
#' @param formatted Defaults to printing results - set to TRUE to silence printing.
#' @return List of information describing Dryad.
#' @examples \dontrun{
#' dr_identify()
#' }
dr_identify <- function(...) {
  oai::id(url = dr_base_oai(...))
}
