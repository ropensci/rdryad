
#' Get 'rdryad' cache data as a \pkg{hoardr} object
#'
#' Used primarily to modify the cache directory and set with
#' \link{dryad_set_cache}.
#' @return A \pkg{hoardr} object defining the cache directory.
#' @export
dryad_get_cache <- function () {
    getOption ("rdryad_cache")
}

#' Set the 'rdryad' cache by passing a \pkg{hoardr} object defining cache data
#' including local path.
#'
#' @param obj A \pkg{hoardr} object returned from \link{dryad_get_cache}.
#' @return (Invisibly) The update cache object.
#' @export
dryad_set_cache <- function (obj) {
    val <- options ("rdryad_cache" = obj)
    invisible (val)
}

