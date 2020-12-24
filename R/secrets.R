# modified from gargle source code

# secret_key_exists() --> TRUE or FALSE
secret_key_exists <- function() {
  key <- Sys.getenv("DRYAD_KEY", "")
  !identical(key, "")
}

# secret_key_get() --> error or key-ified key = hash of charToRaw(key)
secret_key_get <- function() {
  key <- Sys.getenv("DRYAD_KEY", "")
  if (identical(key, "")) stop("Envvar `DRYAD_KEY` is not defined")
  sodium::sha256(charToRaw(key))
}

# Store and retrieve encrypted data
# x is the thing to be encrypted and written to disk
# secret_write(x=Sys.getenv("DRYAD_TOKEN"))
secret_write <- function(x) {
  stopifnot(is.character(x))
  path <- secret_path()
  if (!dir.exists(dirname(path))) {
    dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)
  }
  enc <- sodium::data_encrypt(
    msg = charToRaw(x),
    key = secret_key_get(),
    nonce = secret_nonce()
  )
  attr(enc, "nonce") <- NULL
  writeBin(enc, path)
  return(path)
}

# Generated with sodium::bin2hex(sodium::random(24)). AFAICT nonces are
# primarily used to prevent replay attacks, which shouldn't be a concern here
secret_nonce <- function() {
  sodium::hex2bin("cb36bab652dec6ae9b1827c684a7b6d21d2ea31cd9f766ac")
}

secret_path <- function(path = NULL) {
  file <- ".rdryad-token"
  if (is.null(path)) file else file.path(path, file)
}

# Returns the token as a character string
secret_read <- function() {
  path <- secret_path()
  if (!file.exists(path)) stop(path, " does not exist")
  raw <- readBin(path, "raw", file.size(path))
  z <- sodium::data_decrypt(
    bin = raw,
    key = secret_key_get(),
    nonce = secret_nonce()
  )
  rawToChar(z)
}
