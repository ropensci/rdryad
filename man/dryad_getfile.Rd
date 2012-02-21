\name{dryad_getfile}
\alias{dryad_getfile}
\title{Download Dryad dataset (determines file type, then downloads).}
\usage{
  dryad_getfile(dryadurl)
}
\arguments{
  \item{dryadurl}{Dryad URL for a dataset.}
}
\value{
  A Dryad dataset.
}
\description{
  Download Dryad dataset (determines file type, then
  downloads).
}
\examples{
\dontrun{
dryaddat <- download_url("10255/dryad.1759")
dryad_getfile(dryaddat)
}
}

