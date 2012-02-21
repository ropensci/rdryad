\name{listidentifiers}
\alias{listidentifiers}
\title{Gets all OAI Dryad identifiers.}
\usage{
  listidentifiers(tor,
    url = "http://www.datadryad.org/oai/request", ...,
    curl = getCurlHandle())
}
\arguments{
  \item{tor}{Return list of identifiers to R ("r"), or to
  your directory at "~/." ("dir") (character).}

  \item{url}{the base url for the function (should be left
  to default).}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  List of OAI identifiers for each dataset.
}
\description{
  Gets all OAI Dryad identifiers.
}
\examples{
\dontrun{
identifiers <- listidentifiers('r')

# Data packages
identifiers[[1]]

# Data files
identifiers[[2]]
}
}

