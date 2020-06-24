rdryad
======



[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/rdryad.svg?branch=master)](https://travis-ci.org/ropensci/rdryad)
[![codecov](https://codecov.io/gh/ropensci/rdryad/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rdryad)
[![cran checks](https://cranchecks.info/badges/worst/rdryad)](https://cranchecks.info/pkgs/rdryad)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rdryad)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/rdryad)](https://cran.r-project.org/package=rdryad)

`rdryad` is a package to interface with the Dryad data repository.

* General Dryad API documentation: https://datadryad.org/api/v2/docs/
* Solr API: DEFUNCT
* OAI-PMH: DEFUNCT

## Installation

Install Dryad from CRAN


```r
install.packages("rdryad")
```

development version:


```r
remotes::install_github("ropensci/rdryad")
```


```r
library('rdryad')
```

## Examples

### Get download URLs from a Dryad identifier (DOI)


```r
dryad_files(ids = 57485)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rdryad/issues).
* License: MIT
* Get citation information for `rdryad` in R doing `citation(package = 'rdryad')`
* Please note that this project is released with a [Contributor Code of Conduct][coc]. By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

### Data provided by...

Data is provided from the Dryad API.

[coc]: https://github.com/ropensci/rdryad/blob/master/CODE_OF_CONDUCT.md
