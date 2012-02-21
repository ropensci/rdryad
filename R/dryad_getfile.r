#' Download Dryad dataset (determines file type, then downloads).
#' @import RCurl XML stringr ReadImages gdata ape
#' @param dryadurl Dryad URL for a dataset.
#' @return A Dryad dataset.
#' @export
#' @examples \dontrun{
#' dryaddat <- download_url("10255/dryad.1759")
#' dryad_getfile(dryaddat)
#' }
dryad_getfile <-

function(dryadurl)
{
# ToDo:
# GET READ.JPEG TO WORK
# FIGURE OUT HOW TO DOWNLOAD WORD DOCUMENTS
  file_type <- if(str_detect(dryadurl, ".XLS") == "TRUE") { "xls" } else
		if(str_detect(dryadurl, ".txt") == "TRUE") { "txt" } else
		if(str_detect(dryadurl, ".doc") == "TRUE") { "doc" } else
		if(str_detect(dryadurl, ".csv") == "TRUE") { "csv" } else
		if(str_detect(dryadurl, ".nex") == "TRUE") { "nex" } else
		if(str_detect(dryadurl, ".jpeg") == "TRUE") { "jpg" } else
		if(str_detect(dryadurl, ".jpg") == "TRUE") { "jpg" } else
			end
	if(file_type == "txt") {
		dat <- read.table(dryadurl, header=T, sep="\t")
	} else
	if(file_type == "xls") {
		dat <- read.xls(dryadurl) # requires gdata
	} else
	if(file_type == "csv" & str_detect(scan(dryadurl, what="raw")[1], ";") == "TRUE") {
		dat <- read.csv(dryadurl, sep=";")
	} else
	if(file_type == "csv" & str_detect(scan(dryadurl, what="raw")[1], ";") == "FALSE") {
		dat <- read.csv(dryadurl)
	} else
	if(file_type == "nex") {
		dat <- read.nexus(dryadurl) # requires ape
	}
	#if(file_type == "jpg") {
	#	dat <- read.jpeg(dryadurl) # requires ReadImages
	#} else
	#if(file_type == "doc") {
	#	dat <- read.YYYY(dryadurl)
	#} else
	end
return(dat)
}