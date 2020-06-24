rdryad_cache <- NULL
.onLoad <- function(libname, pkgname){
  hh <- hoardr::hoard()
  hh$cache_path_set("rdryad")
  rdryad_cache <<- hh
}
