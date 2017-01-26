#! /usr/local/bin/Rscript

message("Building md files -------------------------------")
# Update everything

suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(yaml)))

source("books/books.R")
source("yaml2md.R")

old <- dir("docs", pattern = "^[^_]", full.names = TRUE)
unlink(old, recursive = TRUE)

syllabus <- load_syllabus()
units <- load_units()
supplements <- load_supplements()

syllabus %>%
  syllabus_index(units, supplements) %>%
  writeLines("docs/README.md")

syllabus %>%
  syllabus_toc() %>%
  writeLines("docs/_includes/toc.html")

supplements %>%
  supplements_index() %>%
  writeLines("docs/supplements.md")

out_path <- paste0("docs/", names(units), ".md")
units %>%
  map2_chr(names(units), md_unit, supp_index = supplements) %>%
  walk2(out_path, writeLines)

message("Building overview ------------------------------")
source("overview.R")

message("------------------------------------------------")
message("DONE")

