strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, path = NULL, query = list(), headers = list(), ...) {
	con <- crul::HttpClient$new(url = x, opts = list(...), headers = headers)
	res <- con$get(path, query = query)
	res$raise_for_status()
	res$parse("UTF-8")
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
  do.call(file.path, as.list(unlist(list(base, c(...)))))
}
v2_parse <- function(x) {
  jsonlite::fromJSON(x, flatten = TRUE)
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"
dr_base_apiv2 <- function() "https://datadryad.org"

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
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
