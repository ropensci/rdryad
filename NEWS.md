rdryad 0.4.0
============

### NEW FEATURES

* gains new function `dryad_metadata()` to download Dryad file metadata 
* gains new function `dryad_package_dois()` to get file DOIs for a Dryad package DOI (a package can have many files) (#22)

### MINOR IMPROVEMENTS

* `dryad_files` (formerly `download_url()`) now scrapes Dryad page to get URLs to Dryad files instead of using their API, which was not dependable (#26)
* `dryad_fetch` gains a parameter `try_file_names` (a boolean) which if `TRUE` we try to extract file names out of URLs (#26)

### BUG FIXES

* fix to solr `rdryad` functions to hard code use of `xml` return format, and followlocation to follow any redirects (#27)

### DEFUNCT

* `download_url()` is now defunct, see `dryad_files()`

### NOTE

* two new pacakage dependencies: `tibble` and `data.table`

rdryad 0.3.0
============

### NEW FEATURES

* Move to using `solrium` package instead of `solr` package
for interaction with Dryad's Solr backend (#21) (#24)
* Now using `crul` instead of `httr` for HTTP requests (#23)
* gains two new functions `handle2doi` and `doi2handle` to
convert between handles and DOIs, and DOIs and handles,
respectively (#25)
* `download_url` function name has been changed to `dryad_files`, but
you can still use `download_url` until the next version. In addition,
`download_url`/`dryad_files` parameters `id` is changed to `doi`.

### MINOR IMPROVEMENTS

* `dryad_fetch` is improved, and uses `curl::curl_download` instead of
`download.file`. It now accepts >1 input URL, but `destile` length must
equal number of urls.


rdryad 0.2.0
============

### NEW FEATURES

* Re-worked most of the package.
* New package API, some methods are the same, but many are different. (#16)
* New functions (see functions starting with `d_*()`) to interact
with Dryad Solr search engine (#10)
* OAI-PMH functions now using internally the `oai` package. (#14)

### MINOR IMPROVEMENTS

* Slimmed down dependencies to a smaller set.
* Changed license from CC0 to MIT (#17)
* Added more tests (#18)
* Changed function to get files to only download them, and not attempt to
read them into R, which introduces a very long dependency chain (#15)


rdryad 0.1.1
============

### BUG FIXES

* removed read.jpeg as a dependency


rdryad 0.1
==========

### NEW FEATURES

* released to CRAN
