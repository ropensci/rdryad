test_that("dryad_files_download", {
  skip_on_cran()

  vcr::use_cassette("dryad_files_download", {
    aa <- dryad_files_download(ids = 61858)
  })

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, NULL)
  expect_is(aa[[1]], "character")
  expect_match(aa[[1]], "csv")
})

test_that("dryad_files_download accepts more than 1 id", {
  skip_on_cran()

  vcr::use_cassette("dryad_files_download_many_ids", {
    bb <- dryad_files_download(ids = c(61858, 61859))
  })

  expect_is(bb, "list")
  expect_equal(length(bb), 2)
  for (i in bb) expect_is(i, "character")
})

test_that("dryad_files_download fails well", {
  skip_on_cran()

  # ids: required param
  expect_error(dryad_files_download())
  # ids: wrong type
  expect_error(dryad_files_download("4"))
})
