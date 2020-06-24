test_that("dyrad_files", {
  skip_on_cran()

  aa <- dryad_files(ids = 61859)

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "61859")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$`_links`$`stash:files`$href, "character")
  expect_match(aa[[1]]$`_links`$`stash:files`$href, "/api/v2/versions")
})

test_that("dyrad_files accepts more than 1 id", {
  skip_on_cran()
  # can't use vcr, async

  bb <- dryad_files(ids = c(61858, 61859))

  expect_is(bb, "list")
  expect_equal(length(bb), 2)
})

test_that("dyrad_files fails well", {
  skip_on_cran()

  # ids: required param
  expect_error(dryad_files())
  # ids: wrong type
  expect_error(dryad_files("4"))
})
