#' List the sets in the Dryad metadata repository.
#'
#' Retrieve the set structure of Dryad, useful for selective harvesting
#'
#' @export
#' @examples \dontrun{
#' dr_list_sets()
#' dr_list_sets(as = "list")
#' dr_list_sets(as = "raw")
#' library('httr')
#' res <- dr_list_sets(config = verbose())
#' }
dr_list_sets <- function(token = NULL, as = "df", ...) {
  oai::list_sets(url = dr_base_oai(), token = token, as = as, ...)
}
