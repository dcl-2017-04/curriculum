#! /usr/local/bin/Rscript

# Update everything

source("books/books.R")
source("yaml2md.R")

syllabus <- yaml.load_file("syllabus.yml")
syllabus_index(syllabus) %>% writeLines("syllabus/README.md")

weekly <- seq_along(syllabus) %>%
  map_chr(syllabus_week, syllabus = syllabus)

walk2(weekly, file.path("syllabus", week_path(seq_along(syllabus))), writeLines)

