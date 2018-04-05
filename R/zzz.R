strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, ...) {
	cli <- crul::HttpClient$new(url = x, opts = list(...))
	res <- cli$get()
	res$raise_for_status()
	res$parse("UTF-8")
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"

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
