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

setGeneric("resourceDate", function(x) standardGeneric("resourceDate"))
#' extract date of resource
#' @param x instance of AnnoResource
#' @export
setMethod("resourceDate", "AnnoResource", function(x) slot(x, "declaredDate"))

