.onLoad <- function(libname, pkgname){
  hh <- hoardr::hoard()
  hh$cache_path_set("rdryad")
  options ("rdryad_cache" = hh)
}
