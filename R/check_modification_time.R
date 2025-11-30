#' check modification time for content at a URL
#' @import httr2
#' @param url string
#' @examples
#' check_modification_time("http://current.geneontology.org/ontology/go-basic.obo")
#' @export
chk_modification_time = function(url) {
# perplexity.ai Nov 29 2025
 resp <- request(url) |>
   req_method("HEAD") |>
   req_perform()
 
 h <- resp_headers(resp)
 
 last_modified_raw <- h[["last-modified"]]
 last_modified <- if (!is.null(last_modified_raw)) {
   as.POSIXct(last_modified_raw, format = "%a, %d %b %Y %H:%M:%S", tz = "GMT")
 } else {
   NA
 }
 
 etag <- h[["etag"]]
 
 list(last_modified = last_modified, etag = etag)
}
