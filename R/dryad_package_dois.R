#' Get file DOIs for a Dryad package DOI
#'
#' @export
#' @param doi (character) A Dryad package DOI. required
#' @param ... Further args passed on to [crul::HttpClient]
#' @return (character) zero or more DOIs for the files; if 
#' no results a zero length character vector
#' @examples \dontrun{
#' dryad_package_dois('10.5061/dryad.1758')
#' dryad_package_dois('10.5061/dryad.9t0n8')
#' dryad_package_dois('10.5061/dryad.60699')
#' }
dryad_package_dois <- function(doi, ...) {
  assert(doi, "character")
  stopifnot(length(doi) == 1)
  tmp <- dryad_metadata(doi, ...)
  desc <- tmp$desc
  dois <- stats::na.omit(desc$text[ desc$qualifier == "haspart" ])
  attributes(dois) <- NULL
  if (is.null(dois) || length(dois) == 0) return(character())
  return(gsub("doi:", "", dois))
}
