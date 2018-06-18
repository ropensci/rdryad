rdryad
======



[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/rdryad.svg?branch=master)](https://travis-ci.org/ropensci/rdryad)
[![codecov](https://codecov.io/gh/ropensci/rdryad/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/rdryad)
[![cran checks](https://cranchecks.info/badges/worst/rdryad)](https://cranchecks.info/pkgs/rdryad)
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
#> # A tibble: 10 x 2
#>    handle             dc.title_sort                                       
#>    <chr>              <chr>                                               
#>  1 252539             <NA>                                                
#>  2 10255/dryad.8872   Data from: Inconsistency between different measures…
#>  3 10255/dryad.86943  Data from: Quantification of correlational selectio…
#>  4 10255/dryad.36217  Data from: Patterns and processes of dispersal beha…
#>  5 10255/dryad.159843 Data from: Water restriction causes an intergenerat…
#>  6 10255/dryad.84720  Data from: An experimental test of density-dependen…
#>  7 10255/dryad.34100  Data from: Population and life-history consequences…
#>  8 10255/dryad.135812 Data from: Sex-specific density-dependent secretion…
#>  9 10255/dryad.177079 Data from: Reduction of baseline corticosterone sec…
#> 10 10255/dryad.102424 Data from: Climate and habitat interacts to shape t…
```

Dryad data based on an article DOI:


```r
d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
   fl="dc.identifier,dc.title_ac")
#> # A tibble: 1 x 2
#>   dc.identifier                dc.title_ac                                
#>   <chr>                        <chr>                                      
#> 1 doi:10.5061/dryad.8426doi:1… Data from: Minimal ProtoHox cluster inferr…
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
#>    term                                                              value
#>    <chr>                                                             <chr>
#>  1 adaptation|||Adaptation                                           791  
#>  2 population genetics - empirical|||Population Genetics - Empirical 581  
#>  3 speciation|||Speciation                                           482  
#>  4 ecological genetics|||Ecological Genetics                         390  
#>  5 phylogeography|||Phylogeography                                   380  
#>  6 climate change|||climate change                                   359  
#>  7 hybridization|||Hybridization                                     340  
#>  8 conservation genetics|||Conservation Genetics                     301  
#>  9 phylogeny|||phylogeny                                             300  
#> 10 insects|||Insects                                                 284  
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
#> # A tibble: 7 x 1
#>   dc.relation.isreferencedby
#>   <chr>                     
#> 1 doi:10.1111/oik.05215     
#> 2 doi:10.1086/693781        
#> 3 doi:10.1111/jav.01643     
#> 4 doi:10.1002/2017jf004462  
#> 5 doi:10.1111/jav.01633     
#> 6 doi:10.1111/jav.01685     
#> 7 doi:10.1111/ecog.03632
```

### OAI-PMH interface

Identify the service


```r
dr_identify()
#>          repositoryName                               baseURL
#> 1 Dryad Data Repository https://www.datadryad.org/oai/request
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
#>   setSpec              setName            
#>   <chr>                <chr>              
#> 1 hdl_10255_dryad.148  BIRDD              
#> 2 hdl_10255_2          Dryad Data Files   
#> 3 hdl_10255_3          Dryad Data Packages
#> 4 hdl_10255_dryad.7872 DryadLab Activities
#> 5 hdl_10255_dryad.7871 DryadLab Packages  
#> 6 hdl_10255_dryad.2027 KNB                
#> 7 hdl_10255_dryad.2171 TreeBASE           
#> 8 hdl_10255_1          Main
```

Get records


```r
dr_get_records(ids = 'oai:datadryad.org:10255/dryad.8820')
#> $`oai:datadryad.org:10255/dryad.8820`
#> $`oai:datadryad.org:10255/dryad.8820`$header
#> # A tibble: 1 x 3
#>   identifier                         datestamp            setSpec    
#>   <chr>                              <chr>                <chr>      
#> 1 oai:datadryad.org:10255/dryad.8820 2015-10-29T06:27:53Z hdl_10255_2
#> 
#> $`oai:datadryad.org:10255/dryad.8820`$metadata
#> # A tibble: 1 x 9
#>   title  creator  subject  date  type  identifier relation coverage rights
#>   <chr>  <chr>    <chr>    <chr> <chr> <chr>      <chr>    <chr>    <chr> 
#> 1 NEXUS… Janies,… Echinod… 2011… Data… doi:10.50… doi:10.… World's… http:…
```

### Get download URLs from a Dryad identifier (DOI)


```r
dryad_files('10.5061/dryad.1758')
#> [1] "http://datadryad.org/bitstream/handle/10255/dryad.1759/dataset.csv?sequence=1"
#> [2] "http://datadryad.org/bitstream/handle/10255/dryad.1759/README.txt?sequence=2"
```

### Download a file

Does not read file into, just a helper to get data files


```r
dryad_fetch(dryad_files('10.5061/dryad.1758'))
```

By default `dryad_fetch()` will download to temporary files (note that these are cleaned up at the end of your R session). Check out the documentation for other options.

### Get file DOIs from a package DOI


```r
dryad_package_dois('10.5061/dryad.60699')
#> [1] "10.5061/dryad.60699/1" "10.5061/dryad.60699/2" "10.5061/dryad.60699/3"
#> [4] "10.5061/dryad.60699/4" "10.5061/dryad.60699/5" "10.5061/dryad.60699/6"
```

### Get metadata for a DOI

Works for both package DOIs and for DOIs for files within packages


```r
dryad_metadata('10.5061/dryad.9t0n8')
#> $desc
#> # A tibble: 25 x 6
#>    text                    qualifier confidence mdschema element authority
#>    <chr>                   <chr>     <chr>      <chr>    <chr>   <chr>    
#>  1 Lawing, A. Michelle     author    NOVALUE    dc       contri… <NA>     
#>  2 Eronen, Jussi T.        author    NOVALUE    dc       contri… <NA>     
#>  3 Blois, Jessica L.       author    NOVALUE    dc       contri… <NA>     
#>  4 Graham, Catherine H.    author    NOVALUE    dc       contri… <NA>     
#>  5 Polly, P. David         author    NOVALUE    dc       contri… <NA>     
#>  6 2016-05-18T15:17:33Z    accessio… <NA>       dc       date    <NA>     
#>  7 2016-05-18T15:17:33Z    available <NA>       dc       date    <NA>     
#>  8 2016-04-27              issued    <NA>       dc       date    <NA>     
#>  9 doi:10.5061/dryad.9t0n8 <NA>      <NA>       dc       identi… <NA>     
#> 10 Lawing AM, Eronen JT, … citation  <NA>       dc       identi… <NA>     
#> # ... with 15 more rows
#> 
#> $files
#> # A tibble: 0 x 0
#> 
#> $attributes
#> # A tibble: 9 x 2
#>   attr        text                                     
#>   <chr>       <chr>                                    
#> 1 PROFILE     DSPACE METS SIP Profile 1.0              
#> 2 LABEL       DSpace Item                              
#> 3 OBJID       /handle/10255/dryad.116170               
#> 4 ID          hdl:10255/dryad.116170                   
#> 5 OBJEDIT     /admin/item?itemID=159223                
#> 6 xmlns:mets  http://www.loc.gov/METS/                 
#> 7 xmlns:xlink http://www.w3.org/TR/xlink/              
#> 8 xmlns:xsi   http://www.w3.org/2001/XMLSchema-instance
#> 9 xmlns:dim   http://www.dspace.org/xmlns/dspace/dim   
#> 
#> $structMap
#> $structMap$div
#> list()
#> attr(,"DMDID")
#> [1] "dmd_1"
#> attr(,"TYPE")
#> [1] "DSpace Item"
#> 
#> attr(,"LABEL")
#> [1] "DSpace"
#> attr(,"TYPE")
#> [1] "LOGICAL"
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rdryad/issues).
* License: MIT
* Get citation information for `rdryad` in R doing `citation(package = 'rdryad')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

### Data provided by...

Data is provided from the Dryad API.
