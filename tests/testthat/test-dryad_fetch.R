context("dryad_fetch")

test_that("dryad_fetch, works well", {
  skip_on_cran()

  # x <- "http://api.datadryad.org/mn/object/doi:10.5061/dryad.n378d/1/bitstream"
  x <- "http://datadryad.org/bitstream/handle/10255/dryad.1759/dataset.csv?sequence=1"

  aa <- dryad_fetch(x)

  expect_is(aa, "list")
  expect_is(aa[[1]], "character")
  expect_equal(length(aa), 1)
  expect_true(file.exists(aa[[1]]))
})

test_that("dryad_fetch fails well", {
  skip_on_cran()

  expect_error(dryad_fetch(4), "url must be of class character")
  expect_error(dryad_fetch(letters[1:3], letters[1:4]),
    "length\\(url\\) == length\\(destfile\\) is not TRUE")
})
