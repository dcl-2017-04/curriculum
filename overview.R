library(tidyverse)
source("utils.R")
# ----------------
library(ggraph)

weeks <- syllabus %>%
  map("units") %>%
  discard(is.null) %>%
  enframe(name = "week", value = "name") %>%
  unnest(name) %>%
  select(name, week) # igraph expects first column to be node name

needs <- load_units() %>%
  map("needs") %>%
  discard(is.null) %>%
  enframe() %>%
  unnest(value)

needs_graph <- igraph::graph_from_data_frame(needs, vertices = weeks)
igraph::V(needs_graph)$unit <- gsub("-", "\n", names(igraph::V(needs_graph)))

ggraph(needs_graph, layout = "sugiyama") +
  geom_edge_diagonal() +
  geom_node_text(aes(label = name)) +
  scale_y_reverse() +
  theme_void()

ggsave("overview.png", width = 8, height = 6, dpi = 96)
