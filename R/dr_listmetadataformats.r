#' Learn about the Dryad metadata formats available.
#'
#' @export
#' @return List of information on metadata formats.
#' @examples \dontrun{
#' dr_list_metadata_formats()
#' }
dr_list_metadata_formats <- function(...) {
  oai::list_metadataformats(url = dr_base_oai(), ...)
}
