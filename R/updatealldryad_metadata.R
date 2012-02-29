
#'Update metadata for new Dryad oai's for defined time period to an existing csv file.
#' @import RCurl XML stringr ReadImages gdata plyr
#'@param file file containing previous import
#'@param  overwrite Will automatically overwrite existing file. To prevent overwrite, set to FALSE
#'@param  newfile Name for new file to write updated data. If no name is given, new file will have same name as old file with timestamp appended.
#'@export
#'@examples \dontrun{
#' updatealldrayad_metadata(file='~/path/to/data/dryad_metadata.csv',overwrite=T)
#' updatealldrayad_metadata(file='~/path/to/data/dryad_metadata.csv',overwrite=F,overwrite=F,newfile='dryad_new')
#' }
updatealldryad_metadata <- function(file, overwrite = T,
    newfile = NULL,progress="text") {
    df <- read.csv(file, header = T)
    myoailist <- listidentifiers("r")  # get all oai's
    myoailist <- llply(myoailist[[1]], function(x) x$identifier)  # list of file
    old.identifiers <- as.list(str_replace(df$identifier.1,"http://hdl.handle.net/","oai:datadryad.org:"))
    current.identifiers <- myoailist
    new_identifiers <- setdiff(old.identifiers,myoailist)
    new_items <- length(new_identifiers)
    if (length(new_identifiers) == 0) {
        stop("No new records available on Dryad\n")
    }
    if (length(new_identifiers) > 0) {

        # ERRORS ARE HERE
        new_metadata <- llply(new_identifiers, download_dryadmetadata,
            transform = T, .progress = progress)
        new_metadata_ <- new_metadata_[unlist(lapply(new_metadata_,
            function(x) length(x$metadata)) != 0)]
        dryadtodf <- function(x) {
            # fxn to transform list to data.frame
            temp <- xmlToList(x$metadata)
            temp2 <- llply(temp, function(x) ifelse(is.null(x) == TRUE,
                "no entry", x))
            data.frame(temp2)
        }
        df_new <- ldply(new_metadata_, dryadtodf)
        df_updated <- rbind(df, df_new)
    }
    if (overwrite == T) {
        save(df_new, file = file)
    }
    if (overwrite == F) {
        timestamp <- str_replace_all(as.character(Sys.time()), , " ",
            "_")
        new_filename = ifelse(is.null(newfile), paste(str_sub(file,
            1, -5), "_", timestamp, ".csv", sep = ""), newfile)
        save(df, file = new_filename)
        status <-ifelse(overwrite==T,"existing file: ","new file:")
        cat("Added",new_identifiers,"records to",status,new_filename,"\n")
    }
}
