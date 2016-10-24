strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, ...) {
  res <- httr::GET(x, ...)
  if (res$status_code > 201) {
    stop(httr::http_status(res)$message, call. = FALSE)
  }
  httr::content(res, "text", encoding = "UTF-8")
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"
