#' Gets OAI Dryad identifiers
#'
#' @export
#' @inheritParams dr_list_records
#' @return XML character string, data.frame, or list, depending on what 
#' requested witht the `as` parameter
#' @return List of OAI identifiers for each dataset.
#' @examples \dontrun{
#' dr_list_identifiers(from='2010-01-01', until = "2010-06-30")
#' dr_list_identifiers(prefix="mets", from='2015-09-01', until='2015-09-20')
#'
#' identifiers <- dr_list_identifiers('rdf')
#'
#' # Data packages
#' identifiers[[1]]
#'
#' # Data files
#' identifiers[[2]]
#' }
dr_list_identifiers <- function(prefix = "oai_dc", from = NULL, until = NULL,
  set = "hdl_10255_3", token = NULL, as = "df", ...) {

  oai::list_identifiers(url = dr_base_oai(), prefix = prefix, from = from, 
    until = until, set = set, token = token, as = as, ...)
}
