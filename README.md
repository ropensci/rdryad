rdryad
======

[![Build Status](https://api.travis-ci.org/ropensci/rdryad.png)](https://travis-ci.org/ropensci/rdryad)

`rdryad` is a package to interface with the Dryad data repository.

Dryad API documentation here: http://wiki.datadryad.org/wiki/API

There is no need to get an API key, as in some of our other packages. They use an OAI-PMH (Open Archives Initiative Protocol for Metadata Harvesting) interface; see here for a description of OAI-PMH: http://en.wikipedia.org/wiki/Open_Archives_Initiative_Protocol_for_Metadata_Harvesting

We now implement the ImpactStory API.  You can query for the data they serve up using `totimp`.  Use `totimp_dryad` to get metrics for just Dryad datasets.  See here for their documentation: http://total-impact.org/about#toc_2_16


## Quick start

Install Dryad from CRAN

```coffee
install.packages("rdryad")
```

Or install development version of rdryad from GitHub:

```coffee
install.packages("devtools")
require(devtools)
install_github("rdryad", "ropensci")
require(rdryad)
```

**We'll have examples up soon.**

----

Data is provided from the Dryad API.

<a border="0" href="http://wiki.datadryad.org/Data_Access" ><img src="http://wiki.datadryad.org/wg/dryad/images/b/bc/Dryad_web_banner_small_v4.jpg" alt="Dryad API" /></a>