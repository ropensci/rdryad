# install and load packages
# id <- "dryad.46"

download_url <- function(id, curl=getCurlHandle() ){
# Returns the url to data file
# The prefix "10255/dryad." is appended at the beginning of the ID provided
# Example:
#   dryaddat <- download_url("10255/dryad.1759") # get URL for data file
  id_ <- paste("10255/dryad.", id, sep = "")
  mets_metadata <- sprintf("%s/%s/%s", "http://datadryad.org/metadata/handle/", id_, "/mets.xml")
  tt <- getURLContent(mets_metadata, curl=curl)
  page <- xmlParse(tt)
  out <- xpathApply(page, "//mets:FLocat",
             function(x){
               link <- xmlAttrs(x, "xlink:href")
               bitstream <- link["xlink:href"]
               sprintf("%s/%s", "http://datadryad.org", bitstream)
             })
  out_ <- out[laply(out, str_detect, pattern = "sequence=1") == "TRUE"]
  return(out_[[1]])
}


dryad_getfile <- function(x) {
# Function for downloading dryad data (determines file type, then downloads)
# Example:
#  dryaddat <- download_url("10255/dryad.1759")  # First, get the url
#  dryad_getfile(dryaddat) # now can download data object
#
# ToDo:
# GET READ.JPEG TO WORK
# FIGURE OUT HOW TO DOWNLOAD WORD DOCUMENTS
	file_type <- if(str_detect(x[[1]], ".XLS") == "TRUE") { "xls" } else
		if(str_detect(x[[1]], ".txt") == "TRUE") { "txt" } else
		if(str_detect(x[[1]], ".doc") == "TRUE") { "doc" } else
		if(str_detect(x[[1]], ".csv") == "TRUE") { "csv" } else
		if(str_detect(x[[1]], ".nex") == "TRUE") { "nex" } else
		if(str_detect(x[[1]], ".jpeg") == "TRUE") { "jpg" } else
		if(str_detect(x[[1]], ".jpg") == "TRUE") { "jpg" } else
			end
	if(file_type == "txt") {
		dat <- read.table(x, header=T, sep="\t")
	} else
	if(file_type == "xls") {
		dat <- read.xls(x) # requires gdatas
	} else
	if(file_type == "csv" & str_detect(scan(x, what="raw")[1], ";") == "TRUE") {
		dat <- read.csv(x, sep=";")
	} else
	if(file_type == "csv" & str_detect(scan(x, what="raw")[1], ";") == "FALSE") {
		dat <- read.csv(x)
	} else
	if(file_type == "nex") {
		dat <- read.nexus(x) # requires ape
	}
	#if(file_type == "jpg") {
	#	dat <- read.jpeg(x) # requires ReadImages
	#} else
	#if(file_type == "doc") {
	#	dat <- read.YYYY(x)
	#} else
	end
return(dat)
}

ListIdentifiers <- function() {
# Function ListIdentifiers to get all oais
# Examples:
#   alldryadoais <- ListIdentifiers()


# Looks like this is doing a search by date (from 2010-01-01 on)
# We can probably add options to this function to let user choose details of this query,
# ListIdentifiers takes a few possible options:
# http://www.openarchives.org/OAI/openarchivesprotocol.html#ListIdentifiers
# until, from, etc.  On the other hand, doesn't really let us search, so it might be good
# to return the entire dryadlist, which we can use to search for a given author, title, etc
# a return the study ids.
# 	dryadoaiurl <- "http://www.datadryad.org/oai/request?verb=ListIdentifiers&from=2010-01-01&metadataPrefix=oai_dc&set=hdl_10255_2"
  dryadoaiurl <- "http://www.datadryad.org/oai/request?verb=ListIdentifiers&metadataPrefix=oai_dc&set=hdl_10255_2"
	dryad <- xmlTreeParse(dryadoaiurl)
	dryadlist <- xmlToList(dryad) # parsed xml to list
	#dryadoais <- laply(dryadlist, identity) # get URL's for trees in vector
	GetOAI <- function(x) {
		oai <- x$identifier
		oai_ <- str_split(oai, ":")[[1]][3]
		return(oai_)
	}
	oailist <- laply(dryadlist[[3]], GetOAI)
return(oailist)
}


download_dryadmetadata <- function(id, transform) {
# Function to download metadata for individual Dryad id's
# Args:
#   id: Dryad identifier, i.e. "10255/dryad.19"
#   transform: (logical) transform metadata to list, TRUE or FLALSE
# Examples:
#   metadat <- download_dryadmetadata("10255/dryad.1759", T)
#   metadat$metadata # get $identifier, $datestamp, $setSpec, or $metadata
#   metadata <- oaih_transform(metadat$metadata) # transform to a list

	baseurl <- "http://www.datadryad.org/oai"
	oaiid <- paste("oai:datadryad.org:", id, sep="")
	x <- oaih_get_record(baseurl,
		oaiid,
		prefix = "oai_dc",
		transform = transform)
  return(x)
}



getalldryad_metadata <- function(transform, progress, write, dir = FALSE) {
# Function to download metadata for all Dryad oai's for defined time period
# Args:
#   transform: (logical) transform metadata to list, TRUE or FLALSE
#   progress: print progress bar (built in to the call to llply, plyr package)
#   write: (logical) write metadata to local file, TRUE or FALSE
#   dir: FALSE or give directory as e.g. "/Mac/dryad/"
# Examples:
#   mymetdata <- getalldryad_metadata(T, progress = "text", T,
#     "/Mac/R_stuff/Blog_etc/Dryad/")
  myoailist <- ListIdentifiers() # get all oai's
  myoailist <- myoailist[1:60]
  allmetadat <- llply(  # download metadata for all oai's
    myoailist,
    download_dryadmetadata,
    transform = T,
    .progress = progress
  )
  dryadtodf <- function(x) {
    temp <- xmlToList(x$metadata)
    tempout <- data.frame(temp)
    return(tempout)
  }
  df <- ldply(allmetadat, dryadtodf)
  if (write == "TRUE") {
    if (!dir == "FALSE") {
      file <- paste(dir, "dryadmetadata.csv", sep = "")
      write.csv(df, file = file)
      return(df)
    } else
    if (dir == "FALSE") {
      file <- "dryadmetadata.csv"
      write.csv(df, file = file)
      return(df)
    }
  } else
  if (write == "FALSE") {
    return(df)
  }
}




search_dryad <- function(input, terms, fuzzy = 'FALSE', ignorecase = 'TRUE',
  value = 'FALSE', maxdistance = 0.1, loc = 'all') {
# Function to download and search metadata for all Dryad oai's
# Input: Dryad metadata data frame
# Output: a numeric vector of OAI identifier's for datasets that match search
# Args:
#   input: Dryad metadata list, from e.g., getalldryad_metadata function,
#     or load xml from directory (in which case, provide directory)
#   terms: search terms: e.g., "plants", "Whickam"
#   fuzzy: (logical) do fuzzy search, TRUE (uses agrep) or FALSE (uses grep)
#   ignorecase: (logical) if FALSE, pattern matching is case sensitive, and if
#     TRUE, case is ignored during matching
#   value: (logical) if FALSE, a vector containing integer (row) indices of the
#     matches returned, and if TRUE, a vector containing the matching elements
#     themselves is returned
#   maxdistance: maximum distance allowed for a match. As integer, OR fraction
#     of the pattern length, OR a list with possible entries:
#     all (max. overall distance), insertions (max. number/fraction of
#     insertions), deletions (max. number/fraction of deletions),
#     and substitutions (max. number/fraction of substitutions)
#   loc: where you want to search, any of title, creator, description, date, type,
#     identifier, relation, OR "all" for search over all metadata fields
# Examples:
# search_dryad(mymetdata, "map", fuzzy=F, loc="type", maxdistance='all')
# search_dryad(mymetdata, "asddddf", fuzzy=T, loc="all")
# search_dryad(mymetdata, "clustal", fuzzy=F, ignorecase=T, value=F, loc="all")
# search_dryad("/Mac/R_stuff/Blog_etc/Dryad/dryadmetadata.csv", "me", fuzzy=T)

  searchdf <- function(x, terms) {
    if (loc == "all") {
      if (fuzzy == "TRUE") { rowslist <- apply(x, 2, agrep, pattern = terms,
        ignore.case = ignorecase, value = value, max.distance = maxdistance) } else
      if (fuzzy == "FALSE") { rowslist <- apply(x, 2, grep, pattern = terms,
        ignore.case = ignorecase, value = value)}
    } else
    if (!loc == "all") {
      dat <- as.data.frame(str_match(names(x), "[a-z]+"))
      dat[,1] <- as.character(dat[,1])
      dat$rows <- rownames(dat)
      cols_ <- as.numeric(dat[dat[, 1] %in% loc, 2])
      if(fuzzy == "TRUE"){ rowslist <- as.list(apply(data.frame(x[, cols_],
        x[, cols_]), 2, agrep, pattern = terms, ignore.case = ignorecase,
        value = value, max.distance = maxdistance)) } else
      if(fuzzy == "FALSE"){ rowslist <- as.list(apply(data.frame(x[, cols_],
        x[, cols_]), 2, grep, pattern = terms, ignore.case = ignorecase,
        value = value)) }
    }

    if ( class ( try ( do.call(c, rowslist), silent = T ) ) %in% 'try-error')
      { stop("Awwwww snap. No datasets contain your search results") } else
      { rows <- do.call(c, rowslist) }
    rowsus <- sort(unique(rows))
    ids <- subset(x, rownames(x) %in% rowsus, identifier.1)
    oais <- as.numeric(apply(ids, 1, function(x)
      str_split(as.character(x), "dryad.")[[1]][2]))
    return(oais)
  }

  if (class(input) == "data.frame") {
    oais_ <- searchdf(x, terms)
  } else
  if (class(input) == "character") {
    xdf <- read.csv(input)
    oais_ <- searchdf(xdf, terms)
  } else
  {stop("Error: input must be one of class data.frame or directory-file
    location\n or file name if in directory already")}

return(oais_)
}