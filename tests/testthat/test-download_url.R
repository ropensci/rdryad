context("download_url")

test_that("download_url: handle input", {
  skip_on_cran()

  aa <- download_url(handle = '10255/dryad.1759')
  bb <- download_url(handle = '10255/dryad.102551')

  expect_is(aa, "character")
  expect_is(bb, "character")
  expect_true(grepl("datadryad.org/bitstream", aa))
  expect_true(grepl("datadryad.org/bitstream", bb))
  expect_true(grepl("dryad\\.1759", aa))
  expect_true(grepl("dryad\\.102551", bb))
})

# test_that("download_url: doi input", {
#   skip_on_cran()
#
#   aa <- download_url(doi = '10.5061/dryad.01n2q/2')
#
#   expect_is(aa, "character")
#   expect_true(grepl("datadryad.org/bitstream", aa))
#   expect_match(aa, "dryad\\.116171")
# })


test_that("download_url fails well", {
  skip_on_cran()

  expect_error(download_url(doi = "asdfafd"), "Client error:")

  # id param no longer exists
  expect_error(download_url(id = "10255/dryad.1664"),
               "Use 'doi' or 'handle' instead of 'id'")
})
