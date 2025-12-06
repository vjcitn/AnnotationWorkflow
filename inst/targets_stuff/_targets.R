# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("AnnotationWorkflow", "RSQLite")
)

list(
  tar_target(
    name = biocGOinst,  # pulls OBO for GO from geneontology.org
    command = AnnotationWorkflow::getGOobo(destdir=".")
  ),
  tar_target(
    name = textSet,   # gets and names paths to text files after "parsing"
    command = {
      AnnotationWorkflow::parseOBO(biocGOinst, "newOBOtxt")
      fs = dir("newOBOtxt", full=TRUE)
      names(fs) = gsub(".txt", "", basename(fs))
      fs
      }
  ),
  tar_target(
    name = emptyGOsql,
    command = {
      source("make_basicGO.R")
      "basicGO.sqlite"
     }
   ),
  tar_target(
    name = populateGOsql,
    command = {
      con = RSQLite::dbConnect(RSQLite::SQLite(), emptyGOsql)
      graph_df = read.delim(textSet["graph_path"], sep="\t")
      RSQLite::dbWriteTable(con, "graph_path", graph_df, overwrite=TRUE)
      term_df = read.delim(textSet["term"], sep="\t")
      RSQLite::dbWriteTable(con, "term", term_df, overwrite=TRUE)
      term2term_df = read.delim(textSet["term2term"], sep="\t")
      RSQLite::dbWriteTable(con, "term2term", term2term_df, overwrite=TRUE)
      term_definition_df = read.delim(textSet["term_definition"], sep="\t")
      RSQLite::dbWriteTable(con, "term_definition", term_definition_df, overwrite=TRUE)
      term_synonym_df = read.delim(textSet["term_synonym"], sep="\t")
      RSQLite::dbWriteTable(con, "term_synonym", term_synonym_df, overwrite=TRUE)
      m = read.csv("meta.csv")  # FIXME - don't do by hand
      RSQLite::dbWriteTable(con, "metadata", m[,-1], overwrite=TRUE)
      RSQLite::dbDisconnect(con)
      "basicGO.sqlite"
    }
   )
)
