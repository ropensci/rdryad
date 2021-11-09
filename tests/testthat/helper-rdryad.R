library("vcr")
invisible(vcr::vcr_configure(dir = "../fixtures", write_disk_path = "../files"))
vcr::check_cassette_names()

ogpath <- rdryad::dryad_get_cache()$cache_path_get()

testthat::setup({
    obj <- rdryad::dryad_get_cache()
    obj$cache_path_set(full_path = "../files")
    rdryad::dryad_set_cache(obj)
})

testthat::teardown({
    obj <- rdryad::dryad_get_cache()
    obj$cache_path_set(full_path = ogpath)
    rdryad::dryad_set_cache(obj)
})
