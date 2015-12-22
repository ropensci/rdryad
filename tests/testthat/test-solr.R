context("solr - methods")

# * d_solr_facet
# * d_solr_group
# * d_solr_highlight
# * d_solr_mlt
# * aa <- d_solr_search
# * d_solr_stats

test_that("aa <- d_solr_search works", {
  skip_on_cran()

  aa <- d_solr_search(q="Galliard")

  # Basic search, restricting to certain fields
  aa <- d_solr_search(q="Galliard", fl='handle,dc.title_sort')

  # Search all text for a string, but limits results to two specified fields:
  aa <- d_solr_search(q="dwc.ScientificName:drosophila", fl='handle,dc.title_sort')

  # Dryad data based on an article DOI:
  aa <- d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
     fl="dc.identifier,dc.title_ac")

  # All terms in the dc.subject facet, along with their frequencies:
  d_solr_facet(q="location:l2", facet.field="dc.subject_filter", facet.minCount=1,
     facet.limit=10)

  # Article DOIs associated with all data published in Dryad over the past 90 days:
  aa <- d_solr_search(q="dc.date.available_dt:[NOW-90DAY/DAY TO NOW]",
     fl="dc.relation.isreferencedby", rows=10)

  # Data DOIs published in Dryad during January 2011, with results returned in JSON format:
  query <- "location:l2 dc.date.available_dt:[2011-01-01T00:00:00Z TO 2011-01-31T23:59:59Z]"
  aa <- d_solr_search(q=query, fl="dc.identifier", rows=10)

  expect_is(aa, "data.frame")
  expect_is(aa$identifier, "character")
  expect_equal(NROW(aa), length(id))
  expect_true(grepl("dryad", aa$identifier))

  expect_is(bb, "data.frame")
  expect_is(bb$identifier, "character")
  expect_equal(NROW(bb), length(ids))
  expect_true(any(grepl("dryad", bb$identifier)))
})

test_that("dr_get_records fails as expected", {
  skip_on_cran()

  expect_error(dr_get_records(), "argument \"ids\" is missing, with no default")
  expect_error(dr_get_records(id, prefix = 44),
               "\"44\" is not supported")

  library("httr")
  expect_error(dr_get_records(id, config = timeout(0.001)), "Timeout was reached")
})
