test_that("dryad_dataset", {
  skip_on_cran()
  # cant use vcr, async

  aa <- dryad_dataset("10.5061/dryad.f385721n")

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "10.5061/dryad.f385721n")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$`_links`$`stash:download`$href, "character")
  expect_match(aa[[1]]$`_links`$`stash:download`$href, "/api/v2/datasets")
})

test_that("dryad_dataset fails well", {
  skip_on_cran()

  # dois: required param
  expect_error(dryad_dataset())
  # dois: wrong type
  expect_error(dryad_dataset(4))
})
