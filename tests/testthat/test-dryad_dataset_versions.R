test_that("dryad_dataset_versions", {
  skip_on_cran()

  vcr::use_cassette("dryad_dataset_versions", {
    aa <- dryad_dataset_versions(dois = "10.5061/dryad.f385721n")
  })

  expect_is(aa, "list")
  expect_equal(length(aa), 1)
  expect_named(aa, "10.5061/dryad.f385721n")
  expect_equal(aa[[1]]$`_links`$self$href,
    "/api/v2/datasets/doi:10.5061%2Fdryad.f385721n/versions")
  expect_is(aa$`10.5061/dryad.f385721n`$`_embedded`$`stash:versions`,
    "data.frame")
})
