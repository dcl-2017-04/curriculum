#! /usr/local/bin/Rscript

message("Building md files -------------------------------")
# Update everything

suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(yaml)))

source("books/books.R")
source("yaml2md.R")
source("index.R")

old <- dir("docs", pattern = "^[^_]", full.names = TRUE)
old <- setdiff(old, "docs/style.css")
unlink(old, recursive = TRUE)

syllabus <- load_syllabus()
units <- load_units()
supplements <- load_supplements()

syllabus %>%
  theme_index() %>%
  writeLines("docs/index.md")

# syllabus %>%
#   syllabus_index(units, supplements) %>%
#
#
# syllabus %>%
#   syllabus_toc() %>%
#   writeLines("docs/_includes/toc.html")

supplements %>%
  supplements_index() %>%
  writeLines("docs/supplements.md")

out_path <- paste0("docs/", names(units), ".md")
units %>%
  map2_chr(names(units), md_unit, supp_index = supplements, unit_index = units) %>%
  walk2(out_path, writeLines)

message("Copying notes ------------------------------")

dir.create("docs/notes")

notes <- dir("notes/", pattern = "(_files|\\.md)$", full.names = TRUE)
notes %>% walk(file.copy, to = "docs/notes", recursive = TRUE)


message("Building overview ------------------------------")
source("overview.R")

message("------------------------------------------------")
message("DONE")

