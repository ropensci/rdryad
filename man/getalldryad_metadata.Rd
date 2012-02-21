\name{getalldryad_metadata}
\alias{getalldryad_metadata}
\title{Download metadata for all Dryad oai's for defined time period.}
\usage{
  getalldryad_metadata(transform, progress = "text", write,
    dir = FALSE)
}
\arguments{
  \item{transform}{(logical) transform metadata to list,
  TRUE or FLALSE}

  \item{progress}{print progress bar (built in to the call
  to llply, plyr package)}

  \item{write}{(logical) write metadata to local file, TRUE
  or FALSE}

  \item{dir}{FALSE (default) or give directory as e.g.
  "/Mac/dryad/" only if write argument == TRUE}
}
\value{
  A Dryad dataset in a data.frame.
}
\description{
  Download metadata for all Dryad oai's for defined time
  period.
}
\examples{
\dontrun{
mymetdata <- getalldryad_metadata(T, progress = "text", T,
   "/Mac/R_stuff/Blog_etc/Dryad/")
}
}

