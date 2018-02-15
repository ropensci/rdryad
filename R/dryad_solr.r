#' Search the Dryad Solr endpoint.
#'
#' @export
#'
#' @param ... Solr parameters passed on to the respective \pkg{solrium} 
#' package function.
#' @param proxy List of arguments for a proxy connection, including one or
#' more of: `url`, `user`, `pwd`, and `auth`. See [crul::proxy] for help, 
#' which is used to construct the proxy connection.
#' @param callopts Further args passed on to [crul::HttpClient]
#'
#' @details See the \pkg{solrium} package documentation for available
#' parameters. For each of `d_solr_search`, `d_solr_facet`,
#' `d_solr_stats`, and `d_solr_mlt`, `d_solr_group`, and
#' `d_solr_highlight` see the equivalently named function in 
#' \pkg{solrium}.
#' 
#' The `wt` parameter is now hard-coded to `xml` because a recent 
#' change in the Dryad Solr infrastructure makes it impossible to get 
#' JSON output - this shouldn't affect most users. In addition, we 
#' hard code a curl option to follow redirects, just so you're aware.
#'
#' @examples \dontrun{
#' # Basic search
#' d_solr_search(q="Galliard")
#'
#' # Basic search, restricting to certain fields
#' d_solr_search(q="Galliard", fl=c('handle', 'dc.title_sort'))
#'
#' # Search all text for a string, but limits results to two specified fields:
#' d_solr_search(q="dwc.ScientificName:drosophila", fl='handle,dc.title_sort')
#'
#' # Dryad data based on an article DOI:
#' d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
#'    fl="dc.identifier,dc.title_ac")
#'
#' # All terms in the dc.subject facet, along with their frequencies:
#' d_solr_facet(q="location:l2", facet.field="dc.subject_filter", facet.minCount=1,
#'    facet.limit=10)
#'
#' # Article DOIs associated with all data published in Dryad over the past 90 days:
#' d_solr_search(q="dc.date.available_dt:[NOW-90DAY/DAY TO NOW]",
#'    fl="dc.relation.isreferencedby", rows=10)
#'
#' # Data DOIs published in Dryad during January 2011
#' query <- "location:l2 dc.date.available_dt:[2011-01-01T00:00:00Z TO 2011-01-31T23:59:59Z]"
#' d_solr_search(q=query, fl="dc.identifier", rows=10)
#'
#' # Highlight
#' d_solr_highlight(q="bird", hl.fl="dc.description")
#'
#' # More like this
#' d_solr_mlt(q="bird", mlt.count=10, mlt.fl='dc.title_sort', fl='handle,dc.title_sort')
#'
#' # Stats
#' d_solr_stats(q="*:*", stats.field="dc.date.accessioned.year")
#' }
d_solr_search <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$search(params = args, minOptimizedRows = FALSE,
    callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_facet <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$facet(params = args, callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_group <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$group(params = args, callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_highlight <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$highlight(params = args, callopts = callopts, parsetype = "list")
}

#' @export
#' @rdname d_solr_search
d_solr_mlt <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$mlt(params = args, minOptimizedRows = FALSE,
    callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_stats <- function(..., proxy = NULL, callopts = list()) {
  if (!is.null(proxy)) conn_dc <- make_dryad_conn(proxy)
  args <- list(...)
  args$wt <- "xml"
  callopts$followlocation <- TRUE
  conn_dryad$stats(params = args, callopts = callopts)
}

# helpers ---------------------------------------
make_dryad_conn <- function(proxy) {
  solrium::SolrClient$new(host = "datadryad.org",
    path = "solr/search/select", scheme = "https",
    port = NULL, errors = "complete", 
    proxy = proxy)
}
