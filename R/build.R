
themes <- c("Explore", "Wrangle", "Program", "Model", "Communicate", "Workflow")


build <- function() {
  message("Building units ----------------------------------")
  build_units()

  message("Copying notes -----------------------------------")
  build_notes()

  message("Building storyboard -----------------------------")
  build_storyboard()

  message("Building overview graph -------------------------")
  build_overview()

  message("=================================================")
}

clean <- function() {
  old <- dir("docs", pattern = "^[^_]", full.names = TRUE)
  old <- setdiff(old, "docs/style.css")
  unlink(old, recursive = TRUE)
}

build_units <- function() {
  syllabus <- load_syllabus()
  units <- load_units()
  supplements <- load_supplements()

  syllabus %>%
    theme_index(units) %>%
    write_if_different("docs/index.md")

  supplements %>%
    supplements_index() %>%
    write_if_different("docs/supplements.md")

  out_path <- paste0("docs/", names(units), ".md")
  units %>%
    map2_chr(names(units), md_unit, supp_index = supplements, unit_index = units) %>%
    walk2(out_path, write_if_different)
}


build_notes <- function() {
  dir.create("docs/notes", showWarnings = FALSE)

  notes <- dir("notes/", pattern = "(_files|\\.md)$", full.names = TRUE)
  notes %>% walk(file.copy, to = "docs/notes", recursive = TRUE)
}

build_storyboard <- function() {
  key_books <- books %>%
    filter(is.na(depth) | depth < 3) %>%
    transmute(
      book_id = forcats::fct_inorder(id),
      title
    )

  readings <- load_units() %>%
    map("readings") %>%
    discard(is.null) %>%
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
    left_join(readings, by = "unit") %>%
    group_by(week, book_id) %>%
    summarise(units = paste0(unit_link(unit), collapse = ", "))

  key_books %>%
    expand(book_id, week = sprintf("week%02d", 1:10)) %>%
    left_join(unit_readings, by = c("book_id", "week")) %>%
    replace_na(list(units = "")) %>%
    left_join(key_books, by = "book_id") %>%
    select(book_id, title, everything()) %>%
    spread(week, units) %>%
    knitr::kable() %>%
    cat(file = "storyboard.md", sep = "\n")
}


build_overview <- function() {
  raw_units <- load_units()
  units <- tibble(
    name = raw_units %>% names(),
    label = gsub("-", "\n", name),
    theme = raw_units %>% map_chr("theme"),
    needs = raw_units %>% map("needs")
  )

  needs <- units %>% select(name, needs) %>% unnest(needs)

  needs_graph <- igraph::graph_from_data_frame(needs, vertices = units)

  ggraph(needs_graph, layout = "sugiyama") +
    geom_edge_diagonal() +
    geom_node_label(aes(label = label, fill = theme), size = 3) +
    scale_y_reverse() +
    theme_void() +
    scale_fill_brewer(palette = "Set2")

  ggsave("overview.png", width = 14, height = 6, dpi = 96)
}
