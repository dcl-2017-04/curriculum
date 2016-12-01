library(tidyverse)
library(stringr)

lines <- read_lines("books/ggplot2.toc")

parts <- lines %>%
  str_replace("\\\\texttt \\{(.*?)\\}", "\\1") %>%
  str_replace("\\\\_", "_") %>%
  str_match("\\\\numberline \\{(.*?)\\}(.*?)\\}")

isbn <- "978-3-319-24277-4"
base_url <- "http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/"

sections <- tibble(
  id = parts[, 2],
  depth = str_count(id, fixed(".")) + 1,
  title = paste0(parts[, 3], " [ggplot2]")
) %>%
  filter(!is.na(id), !is.na(title), depth == 1) %>%
  mutate(href = paste0(base_url, isbn, "_", id))

write_csv(sections, "books/ggplot2.csv")

