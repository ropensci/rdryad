library("vcr")
invisible(vcr::vcr_configure(dir = "../fixtures", write_disk_path = "../files"))
vcr::check_cassette_names()

ogpath <- rdryad:::get_rdryad_cache()$cache_path_get()

testthat::setup({
    obj <- rdryad:::get_rdryad_cache()
    obj$cache_path_set(full_path = "../files")
    rdryad:::set_rdryad_cache(obj)
})

testthat::teardown({
    obj <- rdryad:::get_rdryad_cache()
    obj$cache_path_set(full_path = ogpath)
    rdryad:::set_rdryad_cache(obj)
})
