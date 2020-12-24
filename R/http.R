dGET <- function(x, path = NULL, query = list(), headers = list(), ...) {
  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  con <- use_token(con)
  res <- con$get(path, query = query)
  res$raise_for_status()
  res$parse("UTF-8")
}

dGETwrite <- function(x, path, doi, query = list(), headers = list(), ...) {
  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  file <- file.path(rdryad_cache$cache_path_get(), paste0(xdoi(doi), ".zip"))
  if (!file.exists(file)) {
    res <- con$get(path, query = query, disk = file)
    res$raise_for_status()
  } else {
    cache_mssg(file)
  }
  return(file)
}

use_token <- function(con) {
  envvar <- Sys.getenv("DRYAD_USE_TOKEN", "")
  if (!is.na(envvar) && !identical(envvar, "")) {
    tok <- dryad_auth()
    con$headers <- utils::modifyList(con$headers, tokhead(tok))
  }
  return(con)
}

dGETasync <- function(urls, query = list(), ...) {
  con <- crul::Async$new(urls = urls,
    opts = list(...), headers = head_json()
  )
  con <- use_token(con)
  res <- con$get(query = query)
  lapply(res, function(z) z$parse("UTF-8"))
}

dPOST <- function(x, path = NULL, body = list(), headers = list(), 
  encode = "multipart", ...) {

  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  res <- con$post(path, body = body, encode = encode)
  check_errs(res)
  res$parse("UTF-8")
}

dPUT <- function(x, path = NULL, body = list(), headers = list(), ...) {
  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  res <- con$put(path, body = body)
  check_errs(res)
  res$parse("UTF-8")
}

dPATCH <- function(x, path = NULL, body = list(), headers = list(), 
  encode = "multipart", ...) {

  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  res <- con$patch(path, body = body, encode = encode)
  check_errs(res)
  res$parse("UTF-8")
}

dDELETE <- function(x, path = NULL, headers = list(), ...) {
  con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
  res <- con$delete(path)
  check_errs(res)
  res$parse("UTF-8")
}

head_json <- function() {
  list(
    `Content-Type` = "application/json",
    `Accept` = "application/json"
  )  
}
v2 <- function(...) {
  base <- "api/v2"
  paths <- c(...)
  if (length(paths) == 0) base else file_path(base, paths)
}
file_path <- function(x, ...) {
  do.call(file.path, as.list(unlist(list(x, c(...)))))
}
v2_parse <- function(x) {
  jsonlite::fromJSON(x, flatten = TRUE)
}

dryad_allowed_urls <- c(
  "https://datadryad.org",
  "https://dryad-stg.cdlib.org"
)
dr_base_api <- function() {
  x <- Sys.getenv("DRYAD_BASE_URL", "")
  if (identical(x, "")) {
    x <- dryad_allowed_urls[1]
  }
  if (!x %in% dryad_allowed_urls) {
    stop("the DRYAD_BASE_URL environment variable must be in set:\n",
      paste0(dryad_allowed_urls, collapse = "  \n"))
  }
  return(x)
}

check_errs <- function(w) {
  if (!w$success()) {
    txt <- tryCatch(w$parse("UTF-8"), error = function(e) e)
    if (inherits(txt, "error")) w$raise_for_status()
    err <- jsonlite::fromJSON(txt)$error
    if (nzchar(err)) stop(sprintf("(HTTP %s) %s", w$status_code, err),
      call. = FALSE)
  }
}
