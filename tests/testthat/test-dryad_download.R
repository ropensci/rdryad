test_that("dryad_download", {
  skip_on_cran()
  skip_on_ci()

  vcr::use_cassette("dryad_download", {
    aa <- dryad_download(dois = "10.5061/dryad.f385721n")
  }, match_requests_on = c("method", "uri"))

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "10.5061/dryad.f385721n")
  expect_is(aa[[1]], "character")
  expect_true(any(grepl("csv", aa[[1]])))
  expect_true(any(grepl("rtf", aa[[1]])))
})

# FIXME: not sure how to get vcr working for dryad_download with many dois
# test_that("dryad_download accepts more than 1 id", {
#   skip_on_cran()

#   dois <- c("10.5061/dryad.f385721n", "10.5061/dryad.7ct1n", "10.5061/dryad.1g626")
#   # vcr::use_cassette("dryad_download_many_dois", {
#   bb <- dryad_download(dois = dois)
#   # }, record = "new_episodes")

#   # expect_is(bb, "list")
#   # expect_equal(length(bb), 2)
#   # for (i in bb) expect_is(i, "character")
# })

test_that("dryad_download fails well", {
  skip_on_cran()

  # dois: required param
  expect_error(dryad_download())
  # dois: wrong type
  expect_error(dryad_download(5))
})
