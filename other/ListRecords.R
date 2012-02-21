# ListRecords.R
#####STILL WORK IN PROGRESS#########
#####STILL WORK IN PROGRESS#########
#####STILL WORK IN PROGRESS#########
#####STILL WORK IN PROGRESS#########
#####STILL WORK IN PROGRESS#########
ListRecords <- function(datefrom, metdatformat) {
# Function ListRecords used to return metadata for records from a date X forward,
#   and specify your metadata format
# Args:
#   datefrom: date for format xxxxxx (character)
#   metdatformat: one of x, y, z (character)
# Examples:
#   ListRecords()
  url <- "http://www.datadryad.org/oai/request?verb=ListRecords&from=2010-01-01&metadataPrefix=oai_dc"
  listrecxml <- xmlTreeParse(getURL(url)[[1]])
  xmllist <- xmlToList(listrecxml)$ListRecords
  xmllist[[4]]
  length(xmllist)
  return(xmlToList(url))
}