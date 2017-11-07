strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

dGET <- function(x, ...) {
	cli <- crul::HttpClient$new(url = x, opts = list(...))
	res <- cli$get()
	res$raise_for_status()
	res$parse("UTF-8")
}

dr_base_oai <- function() "http://www.datadryad.org/oai/request"
