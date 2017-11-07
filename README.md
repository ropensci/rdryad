rdryad
======



[![Build Status](https://travis-ci.org/ropensci/rdryad.svg?branch=master)](https://travis-ci.org/ropensci/rdryad)
[![codecov](https://codecov.io/gh/ropensci/rdryad/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rdryad)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rdryad)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/rdryad)](https://cran.r-project.org/package=rdryad)

`rdryad` is a package to interface with the Dryad data repository.

* General Dryad API documentation: http://wiki.datadryad.org/Data_Access
* [Solr API (http://wiki.datadryad.org/API#SOLR_search_access)](http://wiki.datadryad.org/API#SOLR_search_access)
* OAI-PMH (Open Archives Initiative Protocol for Metadata Harvesting) interface; [Dryad OAI-PMH description](http://wiki.datadryad.org/API#OAI-PMH). [Description of OAI-PMH in general](http://en.wikipedia.org/wiki/Open_Archives_Initiative_Protocol_for_Metadata_Harvesting)

## Installation

Install Dryad from CRAN


```r
install.packages("rdryad")
```

Or install development version of rdryad from GitHub:


```r
devtools::install_github("ropensci/rdryad")
```


```r
library('rdryad')
```

## Examples

### Solr search interface

Basic search, restricting to certain fields for brevity


```r
d_solr_search(q="Galliard", fl='handle,dc.title_sort')
#> # A tibble: 9 x 2
#>               handle
#>                <chr>
#> 1             252539
#> 2  10255/dryad.84720
#> 3   10255/dryad.8872
#> 4  10255/dryad.86943
#> 5  10255/dryad.36217
#> 6 10255/dryad.159843
#> 7  10255/dryad.34100
#> 8 10255/dryad.102424
#> 9 10255/dryad.135812
#> # ... with 1 more variables: dc.title_sort <chr>
```

Dryad data based on an article DOI:


```r
d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
   fl="dc.identifier,dc.title_ac")
#> # A tibble: 1 x 2
#>                                                              dc.identifier
#>                                                                      <chr>
#> 1 doi:10.5061/dryad.8426,doi:10.5061/dryad.8426/1,doi:10.5061/dryad.8426/2
#> # ... with 1 more variables: dc.title_ac <chr>
```

All terms in the dc.subject facet, along with their frequencies:


```r
d_solr_facet(q="location:l2", facet.field="dc.subject_filter", facet.minCount=1,
   facet.limit=10)
#> $facet_queries
#> NULL
#>
#> $facet_fields
#> $facet_fields$dc.subject_filter
#> # A tibble: 10 x 2
#>                                                                 term value
#>                                                                <chr> <chr>
#>  1                                           adaptation|||Adaptation   745
#>  2 population genetics - empirical|||Population Genetics - Empirical   566
#>  3                                           speciation|||Speciation   459
#>  4                         ecological genetics|||Ecological Genetics   380
#>  5                                   phylogeography|||Phylogeography   361
#>  6                                     hybridization|||Hybridization   320
#>  7                                   climate change|||climate change   317
#>  8                     conservation genetics|||Conservation Genetics   286
#>  9                                             phylogeny|||phylogeny   277
#> 10                                                 insects|||Insects   276
#>
#>
#> $facet_pivot
#> NULL
#>
#> $facet_dates
#> NULL
#>
#> $facet_ranges
#> NULL
```

Article DOIs associated with all data published in Dryad over the past 90 days:


```r
d_solr_search(q="dc.date.available_dt:[NOW-90DAY/DAY TO NOW]",
   fl="dc.relation.isreferencedby", rows=10)
#> # A tibble: 8 x 1
#>        dc.relation.isreferencedby
#>                             <chr>
#> 1 doi:10.1016/j.ympev.2017.07.006
#> 2     doi:10.1111/1365-2435.12951
#> 3     doi:10.1111/1365-2664.12985
#> 4     doi:10.1111/1365-2664.12989
#> 5     doi:10.1111/1365-2435.12539
#> 6      doi:10.1098/rsbl.2017.0321
#> 7           doi:10.1111/evo.13322
#> 8           doi:10.1111/mec.14285
```

### OAI-PMH interface

Identify the service


```r
dr_identify()
#>          repositoryName                              baseURL
#> 1 Dryad Data Repository http://api.datadryad.org/oai/request
#>   protocolVersion          adminEmail    earliestDatestamp deletedRecord
#> 1             2.0 admin@datadryad.org 2001-01-01T00:00:00Z    persistent
#>            granularity compression compression.1
#> 1 YYYY-MM-DDThh:mm:ssZ        gzip       deflate
#>                                                                                                                                                                 description
#> 1 OCLC's OAICat Repository FrameworkJeffrey A. Youngjyoung@oclc.orgOCLC1.5.48http://alcme.oclc.org/oaicat/oaicat_icon.gifhttp://www.oclc.org/research/software/oai/cat.shtm
```

List sets


```r
dr_list_sets()
#> # A tibble: 8 x 2
#>                setSpec             setName
#>                  <chr>               <chr>
#> 1  hdl_10255_dryad.148               BIRDD
#> 2          hdl_10255_2    Dryad Data Files
#> 3          hdl_10255_3 Dryad Data Packages
#> 4 hdl_10255_dryad.7872 DryadLab Activities
#> 5 hdl_10255_dryad.7871   DryadLab Packages
#> 6 hdl_10255_dryad.2027                 KNB
#> 7 hdl_10255_dryad.2171            TreeBASE
#> 8          hdl_10255_1                Main
```

Get records


```r
dr_get_records(ids = 'oai:datadryad.org:10255/dryad.8820')
#> $`oai:datadryad.org:10255/dryad.8820`
#> $`oai:datadryad.org:10255/dryad.8820`$header
#> # A tibble: 1 x 3
#>                           identifier            datestamp     setSpec
#>                                <chr>                <chr>       <chr>
#> 1 oai:datadryad.org:10255/dryad.8820 2015-10-29T06:27:53Z hdl_10255_2
#>
#> $`oai:datadryad.org:10255/dryad.8820`$metadata
#> # A tibble: 1 x 9
#>                                                                         title
#>                                                                         <chr>
#> 1 NEXUS file based on phenotypic data and clustalw alignment of molecular dat
#> # ... with 8 more variables: creator <chr>, subject <chr>, date <chr>,
#> #   type <chr>, identifier <chr>, relation <chr>, coverage <chr>,
#> #   rights <chr>
```

### Get a download URL from Dryad identifier


```r
dryad_files('10.5061/dryad.1758')
#> [1] "http://api.datadryad.org/mn/object/doi:10.5061/dryad.1758/1/bitstream"
```

### Download a file

Does not read file into, just a helper to get data files


```r
dryad_getfile(dryad_files('10.5061/dryad.1758'))
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rdryad/issues).
* License: MIT
* Get citation information for `rdryad` in R doing `citation(package = 'rdryad')`

### Data provided by...

Data is provided from the Dryad API.

<a href="http://wiki.datadryad.org/Data_Access"><img src="http://wiki.datadryad.org/wg/dryad/images/b/bc/Dryad_web_banner_small_v4.jpg" alt="Dryad API" /></a>
