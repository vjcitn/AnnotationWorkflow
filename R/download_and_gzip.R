#' use curl to retrieve and gzfile to compress resources
#' @import curl
#' @param url string
#' @param dest_gz a filename to create, with .gz suffix
#' @return invisibly returns path to created compressed file
#' @examples
#' \dontrun{
#' download_and_gzip("http://current.geneontology.org/ontology/go-basic.obo", "./go-basic.obo.gz")
#' }
#' @export
download_and_gzip <- function(url, dest_gz) {
  # curl() creates a read-only connection to the URL
  in_con  <- curl(url, "rb")          # source (HTTP/HTTPS/etc.) 
  out_con <- gzfile(dest_gz, "wb")    # target gzip-compressed file 

  on.exit({
    close(in_con)
    close(out_con)
  }, add = TRUE)

  # Copy raw bytes from URL to gz-compressed file
  repeat {
    buf <- readBin(in_con, what = raw(), n = 65536L)
    if (!length(buf)) break
    writeBin(buf, out_con)
  }

  invisible(dest_gz)
}


