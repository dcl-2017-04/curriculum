library(tidyverse)
library(stringr)

lines <- read_lines("data-raw/ggplot2.toc")

parts <- lines %>%
  str_replace("\\\\texttt \\{(.*?)\\}", "\\1") %>%
  str_replace("\\\\_", "_") %>%
  str_match("\\\\numberline \\{(.*?)\\}(.*?)\\}")

isbn <- "978-3-319-24277-4"
base_url <- "https://link-springer-com.stanford.idm.oclc.org/chapter/10.1007/"

sections <- tibble(
  id = parts[, 2],
  depth = str_count(id, fixed(".")) + 1,
  title = parts[, 3]
) %>%
  filter(!is.na(id), !is.na(title), depth == 1) %>%
  mutate(href = paste0(base_url, isbn, "_", id))

write_csv(sections, "data-raw/ggplot2.csv")

