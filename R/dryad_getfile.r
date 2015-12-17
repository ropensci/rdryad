#' Download Dryad dataset (determines file type, then downloads).
#'
#' @export
#' @param url Dryad URL for a dataset.
#' @param destfile Destination file. If not given, we assign a file name based
#' on URL provided.
#' @param ... Further args passed on to \code{\link{download.file}}
#' @return A path to the file
#' @details This function is a thin wrapper around download.file to get files
#' to your machine only. We don't attempt to read/parse them in to R.
#' @examples \dontrun{
#' url <- download_url('10255/dryad.1759')
#' dryad_getfile(url)
#' }
dryad_getfile <- function(dryadurl)
{
    # Separate out path from rest of URL
    dryadpath <- parse_url(dryadurl)$path
    # search for ".ext" or ".EXT" at the end ($) of the path
    file_type <- if (grepl('\\.xls$', dryadpath, ignore.case=TRUE)) {
        "xls"
    } else if (grepl('\\.txt$', dryadpath, ignore.case=TRUE)) {
        "txt"
    } else if (grepl('\\.doc$', dryadpath, ignore.case=TRUE)) {
        "doc"
    } else if (grepl('\\.csv$', dryadpath, ignore.case=TRUE)) {
        "csv"
    } else if (grepl('\\.nex$', dryadpath, ignore.case=TRUE)) {
        "nex"
    } else if (grepl('\\.tsv$', dryadpath, ignore.case=TRUE)) {
      "tsv"
    } else {
      stop("file type not supported!")
    }
    if (file_type == "txt") {
        dat <- read.table(dryadurl, header = T, sep = "\t")
    } else if (file_type == "xls") {
        dat <- read.xls(dryadurl)  # requires gdata
    } else if (file_type == "csv" & str_detect(scan(dryadurl, what = "raw")[1],
        ";") == "TRUE") {
        dat <- read.csv(dryadurl, sep = ";")
    } else if (file_type == "csv" & str_detect(scan(dryadurl, what = "raw")[1],
        ";") == "FALSE") {
        dat <- read.csv(dryadurl)
    } else if (file_type == "nex") {
        dat <- read.nexus(dryadurl)  # requires ape
    } else if (file_type == "tsv") {
        dat <- read.csv(dryadurl, sep = "\t")
    }
}
