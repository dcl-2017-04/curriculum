library(tidyverse)
source("utils.R")

# devtools::install_github("thomasp85/ggraph", update = FALSE)
library(ggraph)


# Storyboard --------------------------------------------------------------

key_books <- books %>%
  filter(is.na(depth) | depth < 3) %>%
  transmute(
    book_id = forcats::fct_inorder(id),
    title
  )

readings <- load_units() %>%
  map("readings") %>%
  map(. %>% keep(has_name, "book") %>% map_chr("book")) %>%
  enframe(name = "unit", value = "book_id") %>%
  unnest(book_id) %>%
  mutate(book_id = factor(book_id, levels = levels(key_books$book_id)))

unit_link <- function(x) {
  sprintf("[%s](https://dcl-2017-01.github.io/curriculum/%s.html)", x, x)
}

unit_readings <- load_syllabus() %>%
  map("units") %>%
  enframe("week", "unit") %>%
  mutate(week = sprintf("week%02d", week)) %>%
  unnest(unit) %>%
  left_join(readings) %>%
  group_by(week, book_id) %>%
  summarise(units = paste0(unit_link(unit), collapse = ", "))

key_books %>%
  expand(book_id, week = sprintf("week%02d", 1:10)) %>%
  left_join(unit_readings) %>%
  replace_na(list(units = "")) %>%
  left_join(key_books) %>%
  select(book_id, title, everything()) %>%
  spread(week, units) %>%
  knitr::kable() %>%
  cat(file = "storyboard.md", sep = "\n")


# Graph -------------------------------------------------------------------

weeks <- load_syllabus() %>%
  map("units") %>%
  discard(is.null) %>%
  enframe(name = "week", value = "name") %>%
  unnest(name) %>%
  select(name, week) %>% # igraph expects first column to be node name
  mutate(label = gsub("-", "\n", name))

needs <- load_units() %>%
  map("needs") %>%
  discard(is.null) %>%
  enframe() %>%
  unnest(value)

needs_graph <- igraph::graph_from_data_frame(needs, vertices = weeks)

ggraph(needs_graph, layout = "sugiyama") +
  geom_edge_diagonal() +
  geom_node_label(aes(label = label), size = 3) +
  scale_y_reverse() +
  theme_void()

ggsave("overview.png", width = 14, height = 6, dpi = 96)

