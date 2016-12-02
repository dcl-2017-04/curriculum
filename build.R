#! /usr/local/bin/Rscript

# Update everything

source("books/books.R")
source("yaml2md.R")

paths <- dir(pattern = "^week-")
paths %>% walk(build_readme)
