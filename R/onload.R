conn_dryad <- NULL
.onLoad <- function(libname, pkgname){
	x <- solrium::SolrClient$new(host = "v1.datadryad.org",
		path = "solr/search/select", scheme = "http",
		port = NULL, errors = "complete")
  conn_dryad <<- x
}
