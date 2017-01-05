library(tidyverse)
source("utils.R")
# ----------------
library(ggraph)

needs <- load_units() %>%
  map("needs") %>%
  discard(is.null) %>%
  enframe() %>%
  unnest(value)

needs_graph <- igraph::graph_from_data_frame(needs)
igraph::V(needs_graph)$unit <- gsub("-", "\n", names(igraph::V(needs_graph)))

ggraph(needs_graph, layout = "sugiyama") +
  geom_edge_diagonal() +
  geom_node_text(aes(label = unit)) +
  scale_y_reverse() +
  theme_void()

ggsave("overview.png", width = 6, height = 6, dpi = 96)
