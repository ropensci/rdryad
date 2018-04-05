context("oai-pmh - dr_get_records")

id <- 'oai:datadryad.org:10255/dryad.66516'
handles <- c('10255/dryad.66516', '10255/dryad.67646', '10255/dryad.70569')
ids <- paste0('oai:datadryad.org:', handles)

test_that("dr_get_records works", {
  skip_on_cran()

  aa <- suppressWarnings(dr_get_records(id))
  bb <- suppressWarnings(dr_get_records(ids))

  expect_is(aa, "list")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$header, "tbl_df")
  expect_is(aa[[1]]$metadata, "tbl_df")
  expect_match(aa[[1]]$header$identifier, "oai:datadryad.org:10255/dryad.66516")
  expect_match(aa[[1]]$header$datestamp, "[0-9]{4}-[0-9]{2}-[0-9]{2}")
  expect_equal(NROW(aa), length(id))

  expect_is(bb, "list")
  expect_is(bb[[1]], "list")
  expect_is(bb[[1]]$header, "tbl_df")
  expect_is(bb[[1]]$metadata, "tbl_df")
  expect_match(bb[[1]]$header$identifier, "oai:datadryad.org:10255/dryad.66516")
  expect_match(bb[[1]]$header$datestamp, "[0-9]{4}-[0-9]{2}-[0-9]{2}")
  expect_equal(NROW(bb), length(ids))
  expect_true(all(grepl("dryad", vapply(bb, "[[", "", c("header", "identifier")))))
})

test_that("dr_get_records fails as expected", {
  skip_on_cran()

  expect_error(dr_get_records(), "argument \"ids\" is missing, with no default")
  expect_error(suppressWarnings(dr_get_records(id, prefix = 44)),
               "\"44\" is not supported")

  expect_error(dr_get_records(id, timeout_ms = 1), "Timeout was reached")
})
