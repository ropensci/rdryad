#' Get metadata information about a file
#' @export
#' @family dryad-files
#' @param ids (numeric) one or more file ids, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @examples \dontrun{
#' dryad_files(ids = 61859)
#' dryad_files(ids = 61858)
#' dryad_files(ids = c(61858, 61859))
#' }
dryad_files <- function(ids, ...) {
  assert(ids, c('numeric', 'integer'))
  urls <- vapply(ids, function(z)
    file.path(dr_base_apiv2(), v2("files", z)), "")
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, ids)
}

#' Download a specific file
#' @export
#' @family dryad-files
#' @param ids (numeric) one or more file ids, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @note there's no use of cached files here because we can't 
#' determine what the file path will be before making the request,
#' which requires knowing what the data type the file will be
#' @examples \dontrun{
#' dryad_files_download(ids = 61858)
#' dryad_files_download(ids = 61859)
#' }
dryad_files_download <- function(ids, ...) {
  assert(ids, c('numeric', 'integer'))
  rdryad_cache$mkdir()
  paths <- sprintf("api/v2/files/%s/download", ids)
  Map(function(x, y) each_files_download(x, y, ...), ids, paths)
}

each_files_download <- function(id, path, ...) {
  url <- file.path(dr_base_apiv2(), path)
  con <- crul::HttpClient$new(url = url)
  res <- con$get()
  ctype <- res$response_headers$`content-type`
  check <- mime::mimemap %in% ctype
  if (any(check)) file_ext <- paste0(".", names(mime::mimemap)[check])
  file <- file.path(rdryad_cache$cache_path_get(), paste0(id, file_ext))
  file_con <- file(file)
  on.exit(close(file_con))
  writeLines(res$parse("UTF-8"), con = file_con)
  return(file)
}
