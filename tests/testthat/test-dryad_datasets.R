test_that("dryad_datasets", {
  skip_on_cran()

  vcr::use_cassette("dryad_datasets", {
    aa <- dryad_datasets()
  })

  expect_is(aa, "list")
  expect_equal(length(aa), 3)
  expect_named(aa, c("meta", "links", "data"))
  expect_is(aa$meta, "list")
  expect_is(aa$links, "list")
  expect_is(aa$data, "data.frame")
})
