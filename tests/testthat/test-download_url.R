context("dyrad_files")

test_that("dyrad_files, works well", {
  skip_on_cran()

  aa <- dryad_files(doi = '10.5061/dryad.1758')

  expect_is(aa, "character")
  expect_equal(length(aa), 2)
  expect_match(aa, "datadryad.org")
  expect_match(aa, "bitstream")

  expect_length(dryad_files(doi = '10.5061/dryad.60699'), 6)
})

test_that("dyrad_files fails well", {
  skip_on_cran()

  expect_error(dryad_files("4"), "Not Found")
  expect_error(dryad_files(4), "doi must be of class character")
  expect_error(dryad_files(letters[1:3]),
    "length\\(doi\\) == 1 is not TRUE")
})
