#' Download Dryad dataset (determines file type, then downloads).
#' 
#' @import RCurl XML stringr gdata ape
#' @param dryadurl Dryad URL for a dataset.
#' @return A Dryad dataset.
#' @export
#' @examples \dontrun{
#' # csv file
#' dryaddat <- download_url('10255/dryad.1759')
#' dryad_getfile(dryaddat)
#' }
dryad_getfile <- function(dryadurl) 
{
    file_type <- if (str_detect(dryadurl, ".XLS") == "TRUE") {
        "xls"
    } else if (str_detect(dryadurl, ".txt") == "TRUE") {
        "txt"
    } else if (str_detect(dryadurl, ".doc") == "TRUE") {
        "doc"
    } else if (str_detect(dryadurl, ".csv") == "TRUE") {
        "csv"
    } else if (str_detect(dryadurl, ".nex") == "TRUE") {
        "nex"
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
    }
    end
    return(dat)
}