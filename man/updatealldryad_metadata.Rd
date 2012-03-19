\name{updatealldryad_metadata}
\alias{updatealldryad_metadata}
\title{Update metadata for new Dryad oai's for defined time period to an existing csv file.}
\usage{
  updatealldryad_metadata(file, overwrite = T,
    newfile = NULL, progress = "text")
}
\arguments{
  \item{file}{file containing previous import}

  \item{overwrite}{Will automatically overwrite existing
  file. To prevent overwrite, set to FALSE}

  \item{newfile}{Name for new file to write updated data.
  If no name is given, new file will have same name as old
  file with timestamp appended.}
}
\description{
  Update metadata for new Dryad oai's for defined time
  period to an existing csv file.
}
\examples{
\dontrun{
updatealldrayad_metadata(file='~/path/to/data/dryad_metadata.csv',overwrite=T)
updatealldrayad_metadata(file='~/path/to/data/dryad_metadata.csv',overwrite=F,overwrite=F,newfile='dryad_new')
}
}

