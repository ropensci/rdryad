#' Retrieve a Dryad token
#'
#' First, check for a stored, encrypted token.
#' Second, check if that token is expired.
#' If it isn't expired use it; if it is expired get another token
#' Last, store that new token encrypted.
#'
#' For use internally mostly to easily get a token with various
#' approaches. You shouldn't need to run this function yourself; it
#' is used internally where needed to fetch your token.
#'
#' @export
#' @param path (character) path to store the encrypted file. if not supplied,
#' we use the current working directory
#' @details 
#' First, you need to have your Dryad client
#' id and secret. Get these by emailing `help@@datadryad.org` - see
#' https://github.com/CDL-Dryad/dryad-app/blob/main/documentation/apis/submission.md#obtain-a-dryad-api-account
#' for details. Once you get your id and secret store them as
#' environment variables (see above) under the names `DRYAD_CLIENT_ID` for 
#' the id and `DRYAD_CLIENT_SECRET` for the secret, respectively.
#' 
#' You'll need to set a secret key to encrypt your
#' Dryad OAuth token you receive from Dryad. The secret key can be anything
#' you want - just like any password you'd use - you could use a password
#' generator to make it, e.g., 1Password of Lastpass. Set an environment
#' variable with the name `DRYAD_KEY` with the value of the key you created,
#' like `DRYAD_KEY=yourkey`; ideally do so globally in your `.Renviron`,
#' `.bash_profile`, `.zshrc`, or similar file; or do per each R session with
#' [Sys.setenv()]. See [Startup] for additional help on environment
#' variables. You'll get an error about this if this hasn't been done
#' or hasn't been done correctly.
#'
#' Note that your token expires after 10 hours. We take care of checking if your
#' token is expired, and when expired we get a new token.
#' 
#' The token is stored in an encrypted file using package \pkg{sodium} locally
#' in your current working directory - but you can change the path with 
#' the `path` parameter. If you delete this file we'll get a new token and
#' the file will be re-created.
#' @return a token
#' @examples \dontrun{
#' tok <- dryad_auth()
#' tok
#' dryad_auth_test(tok)
#' }
dryad_auth <- function(path = NULL) {
  if (!secret_key_exists())
    stop("set the env var DRYAD_KEY, see ?dryad_auth", call. = FALSE)

  # no encrypted token file: get a new token
  if (!file.exists(secret_path(path))) get_write_token()

  # read token from file
  tok_str <- secret_read()
  tok_list <- jsonlite::fromJSON(tok_str)

  # token is expired, get a new one
  if (is_expired(tok_list)) {
    get_write_token()
    tok_str <- secret_read()
    tok_list <- jsonlite::fromJSON(tok_str)
  }
  return(tok_list$access_token)
}

is_expired <- function(x) {
  now <- Sys.time()
  as.POSIXct(x$expires_at_datetime) < now
}

#' Get a Dryad Token via OAuth client id and secret
#'
#' This does not do the OAUth dance but rather fetches a
#' token using your id and secret. Note that the token expires
#' after 10 hours. See link below for how to get a client id
#' and secret.
#'
#' @export
#' @param id (character) Dryad client id. required
#' @param secret (character) Dryad client secret. required
#' @param ... curl options passed on to [crul::verb-POST]
#' @return a named list: access_token, token_type, expires_in, scope,
#' and created_at
#' @details For more details on authentication see
#' https://github.com/CDL-Dryad/dryad-app/blob/main/documentation/apis/submission.md
#' @examples \dontrun{
#' id <- Sys.getenv('DRYAD_CLIENT_ID')
#' secret <- Sys.getenv('DRYAD_CLIENT_SECRET')
#' out <- dryad_token(id, secret)
#' out
#' # test that your auth token works
#' dryad_auth_test(out$access_token)
#' }
dryad_token <- function(id, secret, ...) {
  con <- crul::HttpClient$new(dr_base_api(), opts = list(...))
  res <- con$post("oauth/token",
    body = list(client_id = id, client_secret = secret,
      grant_type = "client_credentials"), encode = "json")
  check_errs(res)
  x <- res$parse("UTF-8")
  z <- jsonlite::fromJSON(x)
  z$expires_at <- z$created_at + z$expires_in
  z$expires_at_datetime <- as.POSIXct(
    z$expires_at, origin="1970-01-01", tz=Sys.timezone())
  return(z)
}

# return: path to where encrypted token written
get_write_token <- function() {
  id <- Sys.getenv('DRYAD_CLIENT_ID', "")
  if (identical(id, ""))
    stop("`DRYAD_CLIENT_ID` not set", call. = FALSE)
  
  secret <- Sys.getenv('DRYAD_CLIENT_SECRET', "")
  if (identical(secret, ""))
    stop("`DRYAD_CLIENT_SECRET` not set", call. = FALSE)
  
  res <- dryad_token(id, secret)
  secret_write(as.character(jsonlite::toJSON(res, auto_unbox = TRUE)))
}

tokhead <- function(tok) {
  list(Authorization = paste0("Bearer ", tok))
}

#' Check that a Dryad token works
#' @export
#' @param token (character) a Dryad OAUth token. required
#' @return errors if token is expired/invalid; returns named list on
#' success with slots: `message`, `user_id`
#' @examples
#' # dryad_auth_test("some-token")
dryad_auth_test <- function(token) {
  res <- dGET(dr_base_api(), "api/v2/test", headers = tokhead(token))
  jsonlite::fromJSON(res)
}

#' Create a Dryad dataset
#'
#' @param meta an R6 object of class `DryadMetadata`
#' @param doi a DOI for a dataset, of the form `10.1234/dryad.abcd`,
#' without `doi:`. required
#' @param ... curl options
#' @return a list of metadata about the created dataset
#' @examples \dontrun{
#' library(charlatan)
#' lorem <- charlatan::LoremProvider$new()
#' title <- lorem$sentence(nb_words = 10)
#' abstract <- lorem$paragraph(nb_sentences = 10)
#' name <- strsplit(ch_name(), "\\s")[[1]]
#' authors <- list(
#'   list(
#'     firstName = name[1],
#'     lastName = name[2],
#'     email = "myrmecocystus@gmail.com",
#'     affiliation = "The University"
#'   )
#' )
#'
#' # create metadata
#' meta <- dryad_create_metadata(
#'   title = title, abstract = abstract, authors = authors)
#' 
#' # set base url to staging server
#' Sys.setenv(DRYAD_BASE_URL="https://dryad-stg.cdlib.org")
#' 
#' # create dataset
#' created_dataset <- dryad_create_dataset(meta)
#' created_dataset
#' doi <- created_dataset$doi
#'
#' # create file on the dataset
#' file <- file.path(tempdir(), "some-data.csv")
#' write.table(iris, file = file, sep = ",", row.names = FALSE)
#' added_file <- dryad_add_file(doi, file)
#' added_file
#' 
#' # create file by url reference on the dataset
#' # FIXME: have not got this to work yet
#' url = "https://raw.githubusercontent.com/sckott/habanero/master/setup.py"
#' added_file_by_url <- dryad_add_by_url(doi = created_dataset$doi, url,
#'   description = "A file with some things and stuff", mimeType = "text/plain",
#'   path = "setup.py")
#' 
#' # view the dataset
#' # toggle env var to make sure your token is used
#' Sys.setenv(DRYAD_USE_TOKEN=TRUE)
#' dryad_dataset(doi)
#' 
#' # mark the dataset as submitted
#' dryad_submit(doi)
#' 
#' # update the dataset
#' # FIXME: haven't got this to work yet, just
#' # got: "Your dataset cannot be updated now" 
#' new_title <- lorem$sentence(nb_words = 10)
#' meta <- dryad_create_metadata(
#'   title = new_title, abstract = abstract, authors = authors)
#' dryad_dataset(doi)
#' dryad_update_dataset(doi, meta)
#' 
#' # delete a file - FIXME: not working yet
#' # dryad_delete_file()
#' }
dryad_create_dataset <- function(meta, ...) {
  assert(meta, "DryadMetadata")
  json <- meta$to_json()
  x <- dPOST(dr_base_api(), path="api/v2/datasets", body=json, 
    headers=c(head_json(), tokhead(dryad_auth())), ...)
  tmp <- jsonlite::fromJSON(x)
  tmp$doi <- strsplit(tmp$identifier, ":")[[1]][2]
  return(tmp)
}

#' @export
#' @rdname dryad_create_dataset
dryad_update_dataset <- function(doi, meta, ...) {
  assert(doi, "character")
  assert(meta, "DryadMetadata")
  json <- meta$to_json()
  x <- dPUT(dr_base_api(), path=file.path("api/v2/datasets", make_doi(doi)),
    body=json, headers=c(head_json(), tokhead(dryad_auth())), ...)
  tmp <- jsonlite::fromJSON(x)
  tmp$doi <- strsplit(tmp$identifier, ":")[[1]][2]
  return(tmp)
}

#' Upload a file for an in-progress Dryad dataset
#'
#' @param doi a DOI for a dataset, of the form `10.1234/dryad.abcd`,
#' without `doi:`. required
#' @param file a file path; must exist. required
#' @param ... curl options
#' @return a list of metadata about the created file
#' @details See [dryad_create_dataset()] for examples
dryad_add_file <- function(doi, file, ...) {
  assert(doi, "character")
  assert(file, "character")
  mime_type <- mime::guess_type(file)
  path <- sprintf("api/v2/datasets/%s/files/%s", 
    make_doi(doi), curl::curl_escape(basename(file)))
  heads <- utils::modifyList(head_json(), list(`Content-Type` = mime_type))
  x <- dPUT(dr_base_api(), path=path,
    body=crul::upload(file),
    headers=c(heads, tokhead(dryad_auth())), ...)
  jsonlite::fromJSON(x)
}

#' Upload file by URL reference to an in-progress Dryad dataset
#'
#' @param doi a DOI for a dataset, of the form `10.1234/dryad.abcd`,
#' without `doi:`. required
#' @param url a url. required
#' @param ... other optional fields, see Details.
#' @details other optional fields to include:
#' - digest/digestType: (character) if they are added then they will be
#' passed as part of the ingest manifest to Merritt. If the digest doesn't
#' match when Merritt downloads the files from the internet, then Merritt
#' will cause an error on ingesting and you'll need to check/fix it
#' - description: (character) brief description of the file
#' - size: (numeric/integer) file size in bytes
#' - path: (character) can provide a filename when the name is not specified
#' in the URL (this is common when the URL is using an identifier string
#' rather than a file name)
#' - mimeType: (character) the mime type
#' - skipValidation: (boolean) if `TRUE`, will tell DASH to skip the step
#' of validating the existence of the file
#' @return a list of metadata about the created file
#' @details See [dryad_create_dataset()] for examples
dryad_add_by_url <- function(doi, url, ...) {
  assert(doi, "character")
  assert(url, "character")
  path <- sprintf("api/v2/datasets/%s/urls", make_doi(doi))
  fields <- c(url = url, list(...))
  supp_fields <- c("url", "digest", "digestType", "description", "size",
    "path", "mimeType", "skipValidation")
  for (i in names(fields)) 
    if (!i %in% supp_fields) stop(i, " not a supported field", call. = FALSE)
  json <- jsonlite::toJSON(fields, auto_unbox = TRUE)
  x <- dPOST(dr_base_api(), path=path, body=json,
    headers=c(head_json(), tokhead(dryad_auth())), encode = "json")
  jsonlite::fromJSON(x)
}

#' Mark a Dryad dataset as submitted
#'
#' @param doi a DOI for a dataset, of the form `10.1234/dryad.abcd`,
#' without `doi:`. required
#' @param ... curl options
#' @details other optional fields to include:
#' - digest/digestType: (character) if they are added then they will be
#' passed as part of the ingest manifest to Merritt. If the digest doesn't
#' match when Merritt downloads the files from the internet, then Merritt
#' will cause an error on ingesting and you'll need to check/fix it
#' - description: (character) brief description of the file
#' - size: (numeric/integer) file size in bytes
#' - path: (character) can provide a filename when the name is not specified
#' in the URL (this is common when the URL is using an identifier string
#' rather than a file name)
#' - mimeType: (character) the mime type
#' - skipValidation: (boolean) if `TRUE`, will tell DASH to skip the step
#' of validating the existence of the file
#' @return a list of metadata about the created file
#' @details See [dryad_create_dataset()] for examples
dryad_submit <- function(doi, ...) {
  assert(doi, "character")
  path <- paste0("api/v2/datasets/", make_doi(doi))
  body <- list(list(op="replace", path="/versionStatus", value="submitted"))
  heads <- utils::modifyList(head_json(),
    list(`Content-Type` = "application/json-patch+json"))
  x <- dPATCH(dr_base_api(), path=path, body=body,
    headers=c(heads, tokhead(dryad_auth())), encode="json")
  z <- jsonlite::fromJSON(x)
  z$doi <- strsplit(z$identifier, ":")[[1]][2]
  return(z)
}

#' Delete a file for an in-progress Dryad dataset
#'
#' @param id a file id. required
#' @param ... curl options
#' @return a list of metadata
#' @details See [dryad_create_dataset()] for examples
dryad_delete_file <- function(id, ...) {
  assert(id, "character")
  x <- dDELETE(dr_base_api(), path=file.path("api/v2/files", id),
    headers=c(head_json(), tokhead(dryad_auth())))
  jsonlite::fromJSON(x)
}

make_doi <- function(x) {
  if (!grepl("doi:", x)) x <- paste0("doi:", x)
  curl::curl_escape(x)
}
