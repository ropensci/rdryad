#' Download metadata for individual Dryad id's
#'
#' @export
#' @param ids Dryad identifier, i.e. oai:datadryad.org:10255/dryad.8820
#' @param prefix A character string to specify the metadata format in OAI-PMH
#' requests issued to the repository. The default (`"oai_dc"`)
#' corresponds to the mandatory OAI unqualified Dublin Core metadata schema.
#' @param as (character) What to return. One of "df" (for data.frame;
#' default), "list", or "raw" (raw text)
#' @param ... Curl debugging options passed on to `httr::GET`
#' @return XML character string, data.frame, or list, depending on what
#' requested witht the `as` parameter
#' @examples \dontrun{
#' dr_get_records(ids = 'oai:datadryad.org:10255/dryad.8820')
#' handles <- c('10255/dryad.36217', '10255/dryad.86943', '10255/dryad.84720',
#'   '10255/dryad.34100')
#' ids <- paste0('oai:datadryad.org:', handles)
#' dr_get_records(ids)
#' }
dr_get_records <- function(ids, prefix = "oai_dc", as = "df", ...) {
  # oai::get_records(ids, prefix = prefix, url = dr_base_oai(), as = as, ...)
  # FIXME: after moving oai pkg to crul, switch back to oai
  url <- dr_base_oai()
  rd_check_url(url)
  if (as %in% c("list", "df")) as <- "parsed"
  stats::setNames(lapply(ids, each_record_crul, url = url, prefix = prefix,
      as = as, ...), ids)
}

each_record_crul <- function (identifier, url, prefix, as = "df", ...) {
  args <- rc(list(verb = "GetRecord", metadataPrefix = prefix,
      identifier = I(identifier)))
  cli <- crul::HttpClient$new(url = url, opts = list(...))
  res <- cli$get(query = args)
  res$raise_for_status()
  tt <- res$parse("UTF-8")
  xml_orig <- xml2::read_xml(tt)
  oai:::handle_errors(xml_orig)
  if (as == "raw") {
      tt
  } else {
      if (prefix == "oai_dc") {
          oai:::parse_oai_dc(xml_orig)
      } else if (prefix == "oai_datacite") {
          oai:::parse_oai_datacite(xml_orig)
      } else {
          tt
      }
  }
}
