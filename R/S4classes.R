setOldClass("Date")

#' document the provenance of a Bioconductor annotation resource like GO
#' @slot declaredDate Date instance derived from source, usually parsing content to find the date
#' @slot retrievedData Date instance specified for retrieval event
#' @slot sourceURL character(1) full URL
#' @export
setClass("AnnoResource",
  slots=c(declaredDate="Date", retrievedDate="Date",
          sourceURL="character"))

setClass("BiocGO", slots=c(obo_path="character"), contains="AnnoResource")

setMethod("show", "BiocGO", function(object) {
 cat(sprintf("BiocGO instance, resource date %s, retrieved %s\n",
    slot(object, "declaredDate"), slot(object, "retrievedDate")))
})

get_go_date = function(path) {
 txt = grep("data-version", readLines(path, 5), value=TRUE)
 stopifnot(length(text)==1)
 as.Date(basename(strsplit(txt, " ")[[1]][2]))
}

#' retrieve GO in OBO format
#' @param gourl string
#' @param destdir path
#' @note curl is used to retrieve go-basic.obo by default, will not overwrite existing file
#' @export
getGOobo = function(gourl="http://current.geneontology.org/ontology/go-basic.obo", destdir) {
 tfile <- file.path(destdir, basename(gourl))
 if (!file.exists(tfile)) curl::curl_download(gourl, tfile <- file.path(destdir, basename(gourl)))
 else message("found existing go-basic.obo, not overwriting.")
 new("BiocGO", obo_path = normalizePath(tfile), declaredDate=get_go_date(tfile), retrievedDate=Sys.Date(),
    sourceURL=gourl)
 }
  
setGeneric("resourceDate", function(x) standardGeneric("resourceDate"))
setMethod("resourceDate", "AnnoResource", function(x) slot(x, "declaredDate"))

#' get path to an OBO file for GO
#' @param goobj instance of BiocGO
#' @export
obopath = function(goobj) slot(goobj, "obo_path")
