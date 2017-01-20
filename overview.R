library(tidyverse)
source("utils.R")
# ----------------
library(ggraph)

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
  geom_node_label(aes(label = label)) +
  scale_y_reverse() +
  theme_void()

ggsave("overview.png", width = 12, height = 6, dpi = 96)
