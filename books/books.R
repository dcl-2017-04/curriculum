library(tidyverse)

paths <- dir("books/", pattern = "\\.csv$", full.names = TRUE)
paths <- paths %>%
  basename() %>%
  tools::file_path_sans_ext() %>%
  set_names(paths, .)

books <- paths %>%
  map_df(read_csv, col_types = cols(id = col_character()), .id = "source") %>%
  mutate(
    id = paste0(source, "-", id),
    source = NULL
  )

write_csv(books, "books/books.csv")
