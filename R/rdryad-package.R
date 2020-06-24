#' Interface to the Dryad Web services
#'
#' Includes access to Dryad's Solr API, OAI-PMH service, and part of
#' their REST API.
#'
#' @section Package API:
#' 
#' The functions match the three major sets of Dryad API routes for
#' datasets, fiiles and versions.
#'
#' Datasets:
#'
#' - [dryad_dataset()]
#' - [dryad_datasets()]
#' - [dryad_dataset_versions()]
#' 
#' Files:
#'
#' - [dryad_files()]
#' - [dryad_files_download()]
#' 
#' Versions:
#'
#' - [dryad_versions()]
#' - [dryad_versions_files()]
#' - [dryad_versions_download()]
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
#' - [dryad_fetch()] - use instead [dryad_files_download()] or
#' [dryad_versions_download()]
#'
#' @importFrom crul HttpClient
#' @importFrom curl curl_escape
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @importFrom mime mimemap
#' @importFrom hoardr hoard
#' @importFrom zip unzip
#' @name rdryad-package
#' @aliases rdryad
#' @docType package
NULL
