\name{totimp_dryad}
\alias{totimp_dryad}
\title{Get Dryad metrics from Total Impact (http://totalimpact.org/) API.}
\usage{
  totimp_dryad(id = NA, sleep = 0,
    url = "http://total-impact.org/api/v1/items/")
}
\arguments{
  \item{id}{The Dryad identifier - see examples.}

  \item{sleep}{Time (in seconds) before function sends API
  call - defaults to zero.  Set to higher number if you are
  using this function in a loop with many API calls.
  Although, with TotalImpact, you can also just put in
  multiple id's in one call (much faster) instead of using
  a loop (slower).}

  \item{url}{The base URL (do not change from default).}
}
\value{
  A data.frame, or list of data.frame's, of results.
}
\description{
  Get Dryad metrics from Total Impact
  (http://totalimpact.org/) API.
}
\examples{
\dontrun{
totimp_dryad(id = '10.5061/dryad.8671')
totimp_dryad(id = list('10.5061/dryad.8671', '10.5061/dryad.8908'))
}
}

