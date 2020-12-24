strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

cache_mssg <- function(file) {
  fi <- file.info(file)
  size <- round(fi$size/1000000, 3)
  chaftdec <- nchar(strextract(as.character(size), '^[0-9]+'))
  if (chaftdec > 1) size <- round(size, 1)
  message("using cached file: ", file)
  message(
    sprintf("date created (size, mb): %s (%s)", fi$ctime, size))
}

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

rc <- function(l) Filter(Negate(is.null), l)

is_url <- function(x, ...) {
  grepl("https?://", x)
}

rd_check_url <- function(x) {
  if (!all(is_url(x))) {
      stop("One or more of your URLs appears to not be a proper URL",
          call. = FALSE)
  }
}

# replace characters in DOIs
xdoi <- function(x) {
  gsub("\\/|\\.|\\(|\\)|\\[|\\]|;|:|-", "_", x)
}
