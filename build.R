#! /usr/local/bin/Rscript

# Update everything

source("books/books.R")
source("yaml2md.R")

syllabus <- load_syllabus()
units <- load_units()

syllabus %>%
  syllabus_index() %>%
  writeLines("syllabus/README.md")

out_path <- paste0("syllabus/", names(units), ".md")
units %>%
  map_chr(md_unit) %>%
  walk2(out_path, writeLines)
