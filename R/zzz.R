strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, ...) {
  res <- httr::GET(x, ...)
  httr::stop_for_status(res)
  httr::content(res, "text", encoding = "UTF-8")
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"
