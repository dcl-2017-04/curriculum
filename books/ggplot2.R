library(tidyverse)
library(stringr)

lines <- read_lines("books/ggplot2.toc")

parts <- lines %>%
  str_replace("\\\\texttt \\{(.*?)\\}", "\\1") %>%
  str_replace("\\\\_", "_") %>%
  str_match("\\\\numberline \\{(.*?)\\}(.*?)\\}")

sections <- tibble(
  id = parts[, 2],
  depth = str_count(id, fixed(".")) + 1,
  title = parts[, 3]
) %>% filter(!is.na(id), !is.na(title), depth <= 2)

write_csv(sections, "books/ggplot2.csv")

