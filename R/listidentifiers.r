#' Gets all OAI Dryad identifiers.
#' @import RCurl XML
#' @param tor Return list of identifiers to R ("r"), or to your directory
#'    at "~/." ("dir") (character).
#' @param url the base url for the function (should be left to default).
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'    the returned value in here (avoids unnecessary footprint)
#' @return List of OAI identifiers for each dataset.
#' @export
#' @examples \dontrun{
#' identifiers <- listidentifiers('r')
#'
#' # Data packages
#' identifiers[[1]]
#'
#' # Data files
#' identifiers[[2]]
#' }
listidentifiers <- function(tor,
    url = 'http://www.datadryad.org/oai/request',
    ...,
    curl = getCurlHandle() ){
  list_ <- list() # make list to put OIA identifiers into
  argspacks <- list(verb = 'ListIdentifiers', metadataPrefix = 'oai_dc',
        set = 'hdl_10255_2') # list of arguments for packages
  dryadlistout_packs <- getForm(url,
        .params = argspacks,
        ...,
        curl = curl)
	dryad_packs <- xmlTreeParse(dryadlistout_packs) # tree parse
	dryadpackslist <- xmlToList(dryad_packs)[[3]] # parsed xml to list
  if(tor == 'r') {list_[[1]] <- dryadpackslist} else
    if(tor == 'dir') {save(dryadpackslist, file = "~/.dryadpackages.rda")}

  argsfiles <- list(verb = 'ListIdentifiers', metadataPrefix = 'oai_dc',
        set = 'hdl_10255_3') # list of arguments for data files within packages
  dryadlistout_files <- getForm(url,
        .params = argsfiles,
        ...,
        curl = curl)
  dryad_files <- xmlTreeParse(dryadlistout_files) # tree parse
	dryadfileslist <- xmlToList(dryad_files)[[3]] # parsed xml to list
  if(tor == 'r') {list_[[2]] <- dryadfileslist} else
    if(tor == 'dir') {save(dryadfileslist, file = "~/.dryadfiles.rda")}

  if(tor == 'r') list_
}