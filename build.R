#! /usr/local/bin/Rscript

# Update everything

source("books/books.R")
source("yaml2md.R")

old <- dir("docs", full.names = TRUE)
old <- setdiff(old, "docs/_config.yml")
unlink(old, recursive = TRUE)

syllabus <- load_syllabus()
units <- load_units()

syllabus %>%
  syllabus_index() %>%
  writeLines("docs/README.md")

out_path <- paste0("docs/", names(units), ".md")
units %>%
  map2_chr(names(units), md_unit) %>%
  walk2(out_path, writeLines)
