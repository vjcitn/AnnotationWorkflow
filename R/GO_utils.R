#' obtain value of `data-version` in go-basic.obo
#' @param path character string
#' @export
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
 tfile <- file.path(destdir, paste0(basename(gourl), ".gz"))
 if (!file.exists(tfile)) tfile = download_and_gzip(gourl, tfile)
 else message("found existing go-basic.obo.gz, not overwriting.")
 new("BiocGO", obo_path = normalizePath(tfile), declaredDate=get_go_date(tfile), retrievedDate=Sys.Date(),
    sourceURL=gourl)
 }
  
#' get path to an OBO file for GO
#' @param goobj instance of BiocGO
#' @export
obopath = function(goobj) slot(goobj, "obo_path")
