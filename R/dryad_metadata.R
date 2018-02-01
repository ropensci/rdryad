#' Download Dryad file metadata
#'
#' @export
#' @param doi (character) A Dryad DOI for a dataset of files within
#' a dataset
#' @param ... Further args passed on to [crul::HttpClient]
#' @return named (list) with slots for:
#' 
#' - desc: object metadata
#' - files: file information
#' - attributes: metadata about the metadata file
#' - structMap: not sure what this is
#' 
#' @examples \dontrun{
#' dryad_metadata('10.5061/dryad.1758')
#' dryad_metadata('10.5061/dryad.9t0n8/1')
#' dryad_metadata('10.5061/dryad.60699/3')
#' out <- dryad_metadata('10.5061/dryad.60699/5')
#' out$desc$text[out$desc$qualifier %in% c("pageviews", "downloads")]
#' }
dryad_metadata <- function(doi, ...) {
  assert(doi, "character")
  stopifnot(length(doi) == 1)
  url <- sprintf("http://datadryad.org/resource/doi:%s/mets.xml", doi)
  mets_parser(xml2::read_xml(dGET(url, ...)))
}

mets_parser <- function(x) {
  al <- xml2::as_list(x)
  if (!"METS" %in% names(al)) return(x)
  al <- al$METS
  tl_atts <- attributes(al)
  tl_atts$names <- NULL
  tl_atts_df <- as_tb(tl_atts)

  # dsec
  dsec <- al$dmdSec$mdWrap$xmlData$dim
  dseclst <- unname(lapply(dsec, function(z) {
      c(
        stats::setNames(list(z[[1]]), "text"),
        attributes(z)
      )
  }))
  dsec_df <- as_dt(dseclst)

  # fsec
  fsec <- al$fileSec$fileGrp$file
  fsec <- c(
    attributes(fsec),
    attributes(fsec$FLocat)
  )
  fsec_df <- as_tb(fsec)

  # smap
  smap <- al$structMap

  list(
    desc = dsec_df, 
    files = fsec_df, 
    attributes = tl_atts_df,
    structMap = smap)
}

as_dt <- function(x) {
  z <- data.table::setDF(
    data.table::rbindlist(x, fill = TRUE, use.names = TRUE))
  z <- tibble::as_tibble(z)
  return(z)
}

as_tb <- function(x) {
  tibble::as_tibble(
    data.frame(attr = names(x), text = unname(unlist(x)), 
    stringsAsFactors = FALSE))
}
