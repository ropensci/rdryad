library("vcr")
invisible(vcr::vcr_configure(dir = "../fixtures", write_disk_path = "../files"))
vcr::check_cassette_names()

ogpath <- rdryad_cache$cache_path_get()

testthat::setup({
  rdryad_cache$cache_path_set(full_path="tests/files")
})

testthat::teardown({
  rdryad_cache$cache_path_set(full_path=ogpath)
})
