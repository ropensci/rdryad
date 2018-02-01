#' Interface to the Dryad Web services
#'
#' Includes access to Dryad's Solr API, OAI-PMH service, and part of
#' their REST API.
#'
#' @section Package API:
#'
#' The following functions work with the Dryad Solr service
#' - [d_solr_facet()]
#' - [d_solr_group()]
#' - [d_solr_highlight()]
#' - [d_solr_mlt()]
#' - [d_solr_search()]
#' - [d_solr_stats()]
#'
#' The following functions work with the Dryad OAI-PMH service
#'
#' - [dr_get_records()]
#' - [dr_identify()]
#' - [dr_list_identifiers()]
#' - [dr_list_metadata_formats()]
#' - [dr_list_records()]
#' - [dr_list_sets()]
#'
#' The following functions sort out file URLs and help you download
#' those files
#'
#' - [dryad_fetch()]
#' - [dryad_files()]
#' - [dryad_metadata()]
#' - [dryad_package_dois()]
#' 
#' These functions convert between Dryad handles and DOIs
#' 
#' - [handle2doi()]
#' - [doi2handle()]
#'
#' @importFrom solrium SolrClient
#' @importFrom crul HttpClient
#' @importFrom xml2 read_xml xml_find_all xml_ns xml_attr
#' @importFrom oai id list_identifiers list_records list_metadataformats
#' list_sets get_records
#' @name rdryad-package
#' @aliases rdryad
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
NULL
