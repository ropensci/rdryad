test_that("dryad_versions_download", {
  skip_on_cran()
  skip_on_ci()
  
  vcr::use_cassette("dryad_versions_download", {
    aa <- dryad_versions_download(ids = 18774)
  })

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, NULL)
  expect_is(aa[[1]], "character")
  expect_true(any(grepl("csv", aa[[1]])))
  expect_true(any(grepl("rtf", aa[[1]])))
})

test_that("dryad_versions_download accepts more than 1 id", {
  skip_on_cran()
  skip_on_ci()
  # async, can't use vcr

  bb <- dryad_versions_download(ids = c(18774, 18775))

  expect_is(bb, "list")
  expect_equal(length(bb), 2)
  expect_named(bb, NULL)
  expect_true(any(grepl("csv", bb[[1]])))
  expect_true(any(grepl("rtf", bb[[1]])))
  expect_true(any(grepl("csv", bb[[2]])))
})

test_that("dryad_versions_download fails well", {
  skip_on_cran()

  # ids: required param
  expect_error(dryad_versions_download())
  # ids: wrong type
  expect_error(dryad_versions_download("4"))
})
