context("oai-pmh - dr_identify")

test_that("dr_identify works", {
  skip_on_cran()

  aa <- dr_identify()

  expect_is(aa, "data.frame")
  expect_is(aa$repositoryName, "character")
  expect_true(grepl("Dryad", aa$repositoryName))
})
