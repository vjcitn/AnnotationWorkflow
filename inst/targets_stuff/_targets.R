# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("AnnotationWorkflow")
)

# Run the R scripts in the R/ folder with your custom functions:
#tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  tar_target(
    name = biocGOinst,  # pulls OBO for GO from geneontology.org
    command = AnnotationWorkflow::getGOobo(destdir=".")
  ),
  tar_target(
    name = parsed_obo,  # long-running, transforms OBO to text files in folder abc
    command = AnnotationWorkflow::parseOBO(biocGOinst, "abc"),
    format = "file"
  ),
  tar_target(
    name = textSet,   # gets and names paths to text files
    command = {
      fs = dir("abc", full=TRUE)
      names(fs) = gsub(".txt", "", basename(fs))
      fs
      }
  ),
  tar_target(
    name = bar,   # tests the naming
    command = print(textSet["graph_path"])
  )
)
