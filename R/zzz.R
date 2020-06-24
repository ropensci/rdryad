strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, path = NULL, query = list(), headers = list(), ...) {
	con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
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

cache_mssg <- function(file) {
  fi <- file.info(file)
  size <- round(fi$size/1000000, 3)
  chaftdec <- nchar(strextract(as.character(size), '^[0-9]+'))
  if (chaftdec > 1) size <- round(size, 1)
  message("using cached file: ", file)
  message(
    sprintf("date created (size, mb): %s (%s)", fi$ctime, size))
}

dGETasync <- function(urls, query = list(), ...) {
  con <- crul::Async$new(urls = urls,
    opts = list(...),
    headers = list(
      `Content-Type` = "application/json",
      `Accept` = "application/json"
    )
  )
  res <- con$get(query = query)
  lapply(res, function(z) z$parse("UTF-8"))
  # vapply(res, function(z) z$success(), logical(1))
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

dr_base_apiv2 <- function() "https://datadryad.org"

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

rc <- function(l) Filter(Negate(is.null), l)

is_url <- function(x, ...) {
  grepl("https?://", x)
}

rd_check_url <- function(x) {
  if (!all(is_url(x))) {
      stop("One or more of your URLs appears to not be a proper URL",
          call. = FALSE)
  }
}

# replace characters in DOIs
xdoi <- function(x) {
  gsub("\\/|\\.|\\(|\\)|\\[|\\]|;|:|-", "_", x)
}
