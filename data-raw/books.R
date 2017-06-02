library(tidyverse)

paths <- dir("data-raw/", pattern = "\\.csv$", full.names = TRUE)

paths <- paths %>%
  basename() %>%
  tools::file_path_sans_ext() %>%
  set_names(paths, .)

books <- paths %>%
  map_df(read_csv, col_types = cols(id = col_character()), .id = "source") %>%
  mutate(
    id = paste0(source, "-", id),
    source = NULL,
    depth = as.integer(depth)
  )

devtools::use_data(books, overwrite = TRUE)
