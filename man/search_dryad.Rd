\name{search_dryad}
\alias{search_dryad}
\title{Search metadata for search terms using regex (more powerful than searching
   online without regex).}
\usage{
  search_dryad(input, terms, fuzzy = "FALSE",
    ignorecase = "TRUE", value = "FALSE",
    maxdistance = 0.1, loc = "all")
}
\arguments{
  \item{input}{Dryad metadata list, from e.g.,
  getalldryad_metadata function, or load xml from directory
  (in which case, provide directory)}

  \item{terms}{search terms e.g., 'plants', 'Whickam'}

  \item{fuzzy}{(logical) do fuzzy search, TRUE (uses agrep)
  or FALSE (uses grep)}

  \item{ignorecase}{(logical) if FALSE, pattern matching is
  case sensitive, and if TRUE, case is ignored during
  matching}

  \item{value}{(logical) if FALSE, a vector containing
  integer (row) indices of the matches returned, and if
  TRUE, a vector containing the matching elements
  themselves is returned}

  \item{maxdistance}{maximum distance allowed for a match.
  As integer, OR fraction of the pattern length, OR a list
  with possible entries: all (max. overall distance),
  insertions (max. number/fraction of insertions),
  deletions (max. number/fraction of deletions), and
  substitutions (max. number/fraction of substitutions)}

  \item{loc}{where you want to search, any of title,
  creator, description, date, type, identifier, relation,
  OR 'all' for search over all metadata fields}
}
\value{
  A numeric vector of OAI identifier's for datasets that
  match search.
}
\description{
  Search metadata for search terms using regex (more
  powerful than searching online without regex).
}
\details{
  Input is a Dryad metadata data frame from function
  getalldryad_metadata, or from directory (if latter, give
  path with arg 'input').
}
\examples{
\dontrun{
# Search data.frame in R
mymetdata <- getalldryad_metadata(T, progress = 'text', T, '/Mac/R_stuff/Blog_etc/Dryad/')
search_dryad(mymetdata, 'map', fuzzy=F, loc='type', maxdistance='all')
search_dryad(mymetdata, 'asddddf', fuzzy=T, loc='all')
search_dryad(mymetdata, 'clustal', fuzzy=F, ignorecase=T, value=F, loc='all')

# Or search from a saved data.frame on file
search_dryad('/Mac/R_stuff/Blog_etc/Dryad/dryadmetadata.csv', 'me', fuzzy=T)
}
}

