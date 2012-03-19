\name{download_dryadmetadata}
\alias{download_dryadmetadata}
\title{Download metadata for individual Dryad id's.}
\usage{
  download_dryadmetadata(id, transform,
    url = "http://www.datadryad.org/oai")
}
\arguments{
  \item{id}{Dryad identifier, i.e. 19.}

  \item{transform}{(logical) transform metadata to list,
  TRUE or FALSE.}

  \item{url}{the base url for the function (should be left
  to default).}
}
\value{
  Metadata for a Dryad dataset.
}
\description{
  Download metadata for individual Dryad id's.
}
\examples{
\dontrun{
metadat <- download_dryadmetadata('oai:datadryad.org:10255/dryad.8820', T)
metadat <- download_dryadmetadata(8820, T)
metadat$metadata # get $identifier, $datestamp, $setSpec, or $metadata
metadata <- oaih_transform(metadat$metadata) # transform to a list
}
}

