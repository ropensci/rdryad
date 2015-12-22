rdryad
======



[![Build Status](https://api.travis-ci.org/ropensci/rdryad.png)](https://travis-ci.org/ropensci/rdryad)
[![codecov.io](https://codecov.io/github/ropensci/rdryad/coverage.svg?branch=rdryad)](https://codecov.io/github/ropensci/rdryad?branch=rdryad)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rdryad)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rdryad)](http://cran.rstudio.com/web/packages/rdryad)

`rdryad` is a package to interface with the Dryad data repository.

* General Dryad API documentation: http://wiki.datadryad.org/wiki/API
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
#>               handle
#> 1   10255/dryad.8872
#> 2  10255/dryad.84720
#> 3  10255/dryad.86943
#> 4  10255/dryad.36217
#> 5  10255/dryad.34100
#> 6 10255/dryad.102424
#>                                                                                                                            dc.title_sort
#> 1                                                                Data from: Inconsistency between different measures of sexual selection
#> 2             Data from: An experimental test of density-dependent selection on temperament traits of activity, boldness and sociability
#> 3 Data from: Quantification of correlational selection on thermal physiology, thermoregulatory behavior and energy metabolism in lizards
#> 4                                                         Data from: Patterns and processes of dispersal behaviour in arvicoline rodents
#> 5                                              Data from: Population and life-history consequences of within-cohort individual variation
#> 6           Data from: Climate and habitat interacts to shape the thermal reaction norms of breeding phenology across lizard populations
```

Dryad data based on an article DOI:


```r
d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
   fl="dc.identifier,dc.title_ac")
#>                                                              dc.identifier
#> 1 doi:10.5061/dryad.8426,doi:10.5061/dryad.8426/1,doi:10.5061/dryad.8426/2
#>                                                                                                                                          dc.title_ac
#> 1 Data from: Minimal ProtoHox cluster inferred from bilaterian and cnidarian Hox complements,Chourrout-Nature2006_82taxa,Chourrout-Nature2006_92taxa
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
#>                                                                   X1  X2
#> 1                                            adaptation|||Adaptation 590
#> 2  population genetics - empirical|||Population Genetics - Empirical 470
#> 3                                            speciation|||Speciation 357
#> 4                          ecological genetics|||Ecological Genetics 309
#> 5                                    phylogeography|||Phylogeography 288
#> 6                                      hybridization|||Hybridization 243
#> 7                                                  insects|||Insects 236
#> 8                      conservation genetics|||Conservation Genetics 230
#> 9                                  microsatellites|||microsatellites 188
#> 10                                                       fish|||Fish 172
#> 
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
#>                       dc.relation.isreferencedby
#> 1          doi:10.1038/hdy.2012.43,pmid:22892635
#> 2            doi:10.1111/mec.12243,pmid:23432376
#> 3                          doi:10.1890/12-1742.1
#> 4       doi:10.1098/rspb.2013.2647,pmid:24523267
#> 5            doi:10.1111/jeb.12489,pmid:25264126
#> 6           doi:10.1111/j.1095-8312.2012.01937.x
#> 7                    doi:10.1111/1755-0998.12465
#> 8 doi:10.1371/journal.pone.0137005,pmid:26389594
#> 9               doi:10.1371/journal.pone.0137303
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
#> <ListSets> 8 X 2 
#> 
#>                setSpec             setName
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
#> <GetRecord> 1 X 22 
#> 
#>                           identifier            datestamp     setSpec
#> 1 oai:datadryad.org:10255/dryad.8820 2013-07-18T18:07:00Z hdl_10255_2
#> Variables not shown: title (chr), creator (chr), creator.1 (chr),
#>      creator.2 (chr), subject (chr), subject.1 (chr), subject.2 (chr),
#>      subject.3 (chr), subject.4 (chr), date (chr), date.1 (chr), date.2
#>      (chr), type (chr), identifier.2 (chr), identifier.1 (chr), relation
#>      (chr), coverage (chr), coverage.1 (chr), rights (chr)
```

### Get a download URL from Dryad identifier


```r
download_url(id = '10255/dryad.102551')
#> [1] "http://datadryad.org/bitstream/handle/10255/dryad.102551/Beetles%20-%20Darwin%20Core.xls?sequence=1"
```

### Download a file

Does not read file into, just a helper to get data files


```r
dryad_getfile(download_url('10255/dryad.1759'))
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rdryad/issues).
* License: MIT
* Get citation information for `rdryad` in R doing `citation(package = 'rdryad')`

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

### Data provided by...

Data is provided from the Dryad API.

<a href="http://wiki.datadryad.org/Data_Access"><img src="http://wiki.datadryad.org/wg/dryad/images/b/bc/Dryad_web_banner_small_v4.jpg" alt="Dryad API" /></a>
