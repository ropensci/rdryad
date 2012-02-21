\name{totimp}
\alias{totimp}
\title{Get Total Impact (http://totalimpact.org/) metrics or bibliography on a paper.}
\usage{
  totimp(id = NA, fields = "metrics", sleep = 0,
    url = "http://total-impact.org/api/v1/items/")
}
\arguments{
  \item{id}{The DOI, URL, or PubMed ID - see examples.}

  \item{fields}{One of 'metrics' or 'biblio'.}

  \item{url}{The base URL (do not change from default).}
}
\value{
  A list.
}
\description{
  Get Total Impact (http://totalimpact.org/) metrics or
  bibliography on a paper.
}
\examples{
\dontrun{
totimp(id = '10.5061/dryad.8671')
totimp(id = '10.5061/dryad.8671', 'biblio')
totimp(id = list('10.5061/dryad.8671','18428094','http://opensciencesummit.com/program/'), 'biblio')
totimp(id = '18428094', 'biblio')
}
}

