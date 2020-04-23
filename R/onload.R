conn_dryad <- NULL
rdryad_cache <- NULL
.onLoad <- function(libname, pkgname){
	x <- solrium::SolrClient$new(host = "v1.datadryad.org",
		path = "solr/search/select", scheme = "http",
		port = NULL, errors = "complete")
  conn_dryad <<- x

  hh <- hoardr::hoard()
  hh$cache_path_set("rdryad")
  rdryad_cache <<- hh
}
