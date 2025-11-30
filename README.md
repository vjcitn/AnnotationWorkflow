# AnnotationWorkflow

This repository introduces a
second generation of code for annotation resource production for Bioconductor.

# GO.db package

A basic objective is to illustrate a "make"-like approach to creating a GO.db package.

To do this, we define an `AnnoResource` class with information on source URL
and resource creation date, specialize for GO, and maximize the use of R
programming to develop the package.

## Resource retrieval and metadata management

- manage large text files in compressed format
- facilitate quick determination of update requirements

## Intermediate data management

Using legacy scripts, go-basic.obo is parsed into
```
-rw-r--r--  1 vincentcarey  staff  15306428 Nov 29 05:43 graph_path.txt
-rw-r--r--  1 vincentcarey  staff   9850006 Nov 29 05:40 term_definition.txt
-rw-r--r--  1 vincentcarey  staff   8482602 Nov 29 05:40 term_synonym.txt
-rw-r--r--  1 vincentcarey  staff   1652705 Nov 29 05:40 term2term.txt
-rw-r--r--  1 vincentcarey  staff   4169677 Nov 29 05:40 term.txt
```

