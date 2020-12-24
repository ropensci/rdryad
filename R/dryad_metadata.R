#' Create Dryad metadata for a dataset
#' 
#' @export
#' @param ... metadata fields, must be named variables. For available fields
#' see Details.
#' @details The available metadata fields:
#' - title: string (required)
#' - abstract: string (required)
#' - authors: list of named lists (required). required for each author:
#' `firstName`, `lastName`, `email`, `affiliation`
#' - relatedWorks: list of named lists
#' - funders: list of named lists
#' - methods: string
#' - usageNotes: string
#' - keywords: vector of strings
#' - locations: xxx
#' - publicationISSN: string
#' - publicationName: string
#' - manuscriptNumber: string
#' - identifier: string
#' - userId: string
#' - invoiceId: string
#' - skipDataciteUpdate: boolean
#' - skipEmails: boolean
#' - loosenValidation: boolean
#' - preserveCurationStatus: boolean
#' @references https://github.com/CDL-Dryad/dryad-app/blob/main/documentation/apis/dataset_metadata.md
#' @examples
#' # bad
#' # dryad_create_metadata(title = "Foo bar",
#' #   abstract = "And then and stuff", authors = "Adsf")
#' # dryad_create_metadata(title = TRUE,
#' #   abstract = "And then and stuff", authors = "Adsf")
#' # dryad_create_metadata(title = "Foo bar", abstract = 5,
#' #   authors = "Adsf")
#'
#' # good
#' x <- dryad_create_metadata(
#'   title = "Foo bar", abstract = "And then and stuff",
#'   authors = list(
#'     list(
#'       firstName = "Wanda", 
#'       lastName = "Jackson",
#'       email = "wanda.jackson@example.com", 
#'       affiliation = "University of the Example"
#'     )
#'   )
#' )
#' x
#' x$to_json()
dryad_create_metadata <- function(...) {
  obj <- DryadMetadata$new(...)
  obj$check_vars()
  return(obj)
}

DryadMetadata <- R6::R6Class('DryadMetadata',
  public = list(
    vars = list(),
    vartypes = list(
      character = c("title", "abstract", "methods", "usageNotes"),
      vector = c("keywords"),
      bool = c("skipDataciteUpdate", "skipEmails",
        "loosenValidation", "preserveCurationStatus"),
      list_of_named_lists = c("authors", "relatedWorks", "funders")
    ),

    #' @description print method for `DryadMetadata` objects
    #' @param x self
    #' @param ... ignored
    print = function(x, ...) {
      cat("<dryad metadata> ", sep = "\n")
      cat(paste0("  title: ", self$vars$title), sep = "\n")
      cat(paste0("  absract: ", self$vars$abstract), sep = "\n")
      cat("  authors: ", sep = "\n")
      for (i in seq_along(self$vars$authors)) {
        z <- self$vars$authors[[i]]
        cat(paste0("    name: ", paste(z$firstName, z$lastName)), sep = "\n")
      }
      invisible(self)
    },

    #' @description Create a new `DryadMetadata` object
    #' @param title (character) one or more URLs
    #' @param abstract any curl options
    #' @param authors a [proxy()] object
    #' @return A new `DryadMetadata` object
    initialize = function(...) {
      self$vars <- list(...)
      # no vars passed
      if (length(self$vars) == 0) stop("no variables passed, see ?dryad_create_metadata")
      # check for required fields
      req <- c('title', 'abstract', 'authors')
      for (i in seq_along(req)) {
        if (is.null(self$vars[[ req[i] ]])) {
          stop("required field not included: ", req[i], call. = FALSE)
        }
      }
      # check that all vars are known
      if (!all(names(self$vars) %in% unname(unlist(self$vartypes)))) {
        stop("one or more variables not in allowed set, see ?dryad_create_metadata",
          call. = FALSE)
      }
    },

    #' @description Serialize to JSON
    #' @param ... further arguments passed on to [jsonlite::toJSON()]
    #' @return json
    to_json = function(...) {
      jsonlite::toJSON(self$vars, auto_unbox = TRUE, ...)
    },

    check_vars = function() {
      self$check_character()
      self$check_named_lists()
    },
    check_character = function() {
      for (i in seq_along(self$vartypes$character)) {
        if (!is.null(self$vartypes$character)) {
          var <- self$vartypes$character[i]
          private$assrt(self$vars[[var]], var, "character")
        }
      }
    },
    check_named_lists = function() {
      for (i in seq_along(self$vartypes$list_of_named_lists)) {
        if (!is.null(self$vartypes$list_of_named_lists)) {
          var <- self$vartypes$list_of_named_lists[i]
          # top level is a list
          private$assrt(self$vars[[var]], var, "list")
          # each element is a named list
          for (j in seq_along(self$vars[[var]])) {
            varj <- names(self$vars[[var]])[j]
            private$assrt(self$vars[[var]][[j]], varj, "list")
            if (!all(nzchar(names(self$vars[[var]][[j]])))) {
              stop("all list elements must be named", call. = FALSE)
            }
          }
        }
      }
    }
  ),
  private = list(
    assrt = function(x, name, y) {
      if (!is.null(x)) {
        if (!inherits(x, y)) {
          stop(name, " must be of class ",
               paste0(y, collapse = ", "), call. = FALSE)
        }
      }
    }
  )
)
