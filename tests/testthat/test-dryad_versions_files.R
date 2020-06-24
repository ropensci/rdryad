test_that("dryad_versions_files", {
  skip_on_cran()
  # async, can't use vcr

  aa <- dryad_versions_files(ids = 18774)

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "18774")
  expect_is(aa$`18774`$`_embedded`$`stash:files`, "data.frame")
})

test_that("dryad_versions_files accepts more than 1 id", {
  skip_on_cran()
  # async, can't use vcr

  bb <- dryad_versions_files(ids = c(18774, 18775))

  expect_is(bb, "list")
  expect_equal(length(bb), 2)
  expect_named(bb, c("18774", "18775"))
})

test_that("dryad_versions_files fails well", {
  skip_on_cran()

  # ids: required param
  expect_error(dryad_versions_files())
  # ids: wrong type
  expect_error(dryad_versions_files("4"))
})
