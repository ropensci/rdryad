# examples.R
require(dryad)

# Get the URL for a data file
dryaddat <- download_url("10255/dryad.1759")

# Get a file given the URL
## FIXME: I get an error on this
file <- dryad_getfile(dryaddat)

## Given the very heterogeneous content of files, may be difficult to automate this.
## even once filetype is detected correctly, need to specify the delimiters, etc
## For instance, the user can read dryaddat is a .csv, first try to import gets wrong delimiter:
dat <- read.csv(dryaddat)
dat <- read.csv(dryaddat, ";") # This file happens to be ; delimited instead.
dat


# Get all OAIs
alldryadoais <- get_dryadoais()

# Download metadata for a given study, and transform to a list
metadat <- download_dryadmetadata("10255/dryad.1759", TRUE)

# take a look at the different elements
metadat$metadata # get $identifier, $datestamp, $setSpec, or $metadata

# Can use OAIHarvester functions on the metadata
require(OAIHarvester) # if user wants to access the oai functions, need to import it.  we could make it a dependency instead
metadata <- oaih_transform(metadat$metadata) # transform to a list

