context("oai-pmh - dr_list_sets")

test_that("dr_list_sets works - output formats", {
  skip_on_cran()

  aa <- suppressWarnings(dr_list_sets())
  bb <- suppressWarnings(dr_list_sets(as = "list"))
  cc <- suppressWarnings(dr_list_sets(as = "raw"))

  expect_is(aa, "data.frame")
  expect_is(bb, "list")
  expect_is(cc, "list")
  expect_is(cc[[1]], "character")
})

test_that("dr_list_sets fails well", {
  skip_on_cran()

  expect_error(suppressWarnings(dr_list_sets(token = 5)),
               "The value of the resumptionToken argument is invalid or expired")
})

test_that("dr_list_sets curl options work", {
  skip_on_cran()

  library("httr")
  expect_error(dr_list_sets(config = timeout(0.001)), "Timeout was reached")
})
