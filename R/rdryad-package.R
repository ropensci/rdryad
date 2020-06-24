#' Interface to the Dryad Web services
#'
#' Includes access to Dryad's Solr API, OAI-PMH service, and part of
#' their REST API.
#'
#' @section Package API:
#'
#' The following functions sort out file URLs and help you download
#' those files
#'
#' - [dryad_fetch()]
#' 
#' @section Defunct:
#' 
#' The Dryad Solr API is no longer being updated, so the functions
#' that used to work with it are all defunct, see [solr-defunct]
#'
#' The Dryad OAI-PMH service is no longer being updated, so the functions
#' that used to work with it are all defunct, see [oai-defunct]
#' 
#' More defunct functions:
#' 
#' - [dryad_metadata()]
#' - [dryad_package_dois()]
#' - [handle2doi()]
#' - [doi2handle()]
#' - [dryad_files()]
#'
#' @importFrom crul HttpClient
#' @importFrom xml2 read_xml xml_find_all xml_ns xml_attr
#' @importFrom jsonlite fromJSON
#' @name rdryad-package
#' @aliases rdryad
#' @docType package
NULL
