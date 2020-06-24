test_that("dryad_versions", {
  skip_on_cran()
  # async, can't use vcr

  aa <- dryad_versions(ids = 18774)

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "18774")
  expect_is(aa[[1]]$authors, "data.frame")
})

test_that("dryad_versions accepts more than 1 id", {
  skip_on_cran()
  # async, can't use vcr

  bb <- dryad_versions(ids = c(18774, 18775))

  expect_is(bb, "list")
  expect_equal(length(bb), 2)
  expect_named(bb, c("18774", "18775"))
})

test_that("dryad_versions fails well", {
  skip_on_cran()

  # ids: required param
  expect_error(dryad_versions())
  # ids: wrong type
  expect_error(dryad_versions("4"))
})
