# `rdryad` #

`rdryad` is a package to interface with the Dryad data repository.

Dryad API documentation here: http://wiki.datadryad.org/wiki/API

There is no need to get an API key, as in some of our other packages. They use an OAI-PMH (Open Archives Initiative Protocol for Metadata Harvesting) interface; see here for a description of OAI-PMH: http://en.wikipedia.org/wiki/Open_Archives_Initiative_Protocol_for_Metadata_Harvesting

We now implement the Total Impact API.  You can query for the data they serve up using `totimp`.  Use `totimp_dryad` to get metrics for just Dryad datasets.  See here for their documentation: http://total-impact.org/about#toc_2_16

Install Dryad from CRAN (http://cran.r-project.org/web/packages/available_packages_by_name.html), or 

install Dryad from GitHub:

```R
install.packages("devtools")
require(devtools)
install_github("rdryad", "ropensci")
require(rdryad)
```

See the rOpenSci rdryad tutorial here:  http://ropensci.org/tutorials/dryad-tutorial/