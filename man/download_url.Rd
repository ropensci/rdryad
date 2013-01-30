\name{download_url}
\alias{download_url}
\title{Download URL for a Dryad id.}
\usage{
  download_url(id, curl = getCurlHandle())
}
\arguments{
  \item{id}{Dryad identifier, i.e. '10255/dryad.19'.}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  A URL for dataset for the Dryad id.
}
\description{
  Download URL for a Dryad id.
}
\examples{
\dontrun{
download_url(id='10255/dryad.1759')
}
}

