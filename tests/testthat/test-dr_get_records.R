context("oai-pmh - dr_get_records")

id <- 'oai:datadryad.org:10255/dryad.8820'
handles <- c('10255/dryad.36217', '10255/dryad.86943', '10255/dryad.84720', '10255/dryad.34100')
ids <- paste0('oai:datadryad.org:', handles)

test_that("dr_get_records works", {
  skip_on_cran()

  aa <- dr_get_records(id)
  bb <- dr_get_records(ids)

  expect_is(aa, "list")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$header, "data.frame")
  expect_is(aa[[1]]$metadata, "data.frame")
  expect_is(aa[[1]]$header$identifier, "character")
  expect_equal(NROW(aa[[1]]$metadata), length(id))
  expect_true(grepl("dryad", aa[[1]]$header$identifier))

  expect_is(bb, "list")
  expect_is(bb[[1]], "list")
  expect_is(bb[[3]], "list")
  expect_is(bb[[3]]$metadata$identifier, "character")
  expect_equal(length(bb), length(ids))
  expect_true(any(grepl("dryad", bb[[4]]$metadata$identifier)))
})

test_that("dr_get_records fails as expected", {
  skip_on_cran()

  expect_error(dr_get_records(), "argument \"ids\" is missing, with no default")
  expect_error(dr_get_records(id, prefix = 44),
               "\"44\" is not supported")

  library("httr")
  expect_error(dr_get_records(id, config = timeout(0.001)), "Timeout was reached")
})
