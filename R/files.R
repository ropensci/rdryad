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
    file.path(dr_base_api(), v2("files", z)), "")
  tmp <- dGETasync(urls = urls, ...)
  parse_each(tmp, ids)
}

#' Download a specific file
#' @export
#' @family dryad-files
#' @param ids (numeric) one or more file ids, required
#' @param ... Further args passed on to [crul::verb-GET]
#' @return a list of lists, each named by the input DOI
#' @note UPDATE: we used to not use caching in this fxn; we do now
#' as of 2020-12-15
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

# FIXME: this is not complete
binary_formats <- c(
  "docx", "doc", "xls", "xlsx", "zip", "rar", "7z", "tar", "iso", "mdb",
  "accde", "frm", "sqlite", "exe", "dll", "so", "class", "pdf", "ppt",
  "pptx", "odt", "mp3", "aac", "wav", "flac", "ogg", "mka", "wma", "mp4",
  "mkv", "avi", "mov", "mpg", "vob", "jpg", "png", "gif", "bmp", "tiff",
  "psd"
)

each_files_download <- function(id, path, ...) {
  url <- file.path(dr_base_api(), path)
  con <- crul::HttpClient$new(url = url)
  res <- con$get()
  ctype <- res$response_headers$`content-type`
  check <- mime::mimemap %in% ctype
  file_ext <- ""
  if (any(check)) {
    exts <- names(mime::mimemap)[check]
    ext <- if (length(exts) > 1) exts[1] else exts
    # special case for text/plain, always use .txt
    if ("text/plain" == ctype) ext <- "txt"
    file_ext <- paste0(".", ext)
  }
  file <- file.path(rdryad_cache$cache_path_get(), paste0(id, file_ext))
  if (ext %in% binary_formats) {
    file_con <- file(file, "wb")
    writeBin(res$content, con = file_con)
  } else {
    file_con <- file(file)
    writeLines(res$parse("UTF-8"), con = file_con)
  }
  on.exit(close(file_con))
  return(file)
}
