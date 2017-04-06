
md_unit <- function(unit, unit_name, unit_index, supp_index) {
  paste0(
    "---\n",
    "title: ", unit$title, "\n",
    "---\n",
    "\n",
    md_generated_by(paste0(unit_name, ".yml")),
    "# ", unit$title, " <small class='", tolower(unit$theme), "'>[", unit$theme, "]</small>\n",
    paste0(
      c(md_needs(unit$needs, unit_index), md_leads(unit_name, unit_index)),
      collapse = "  \n"
    ),
    "\n\n",
    unit$desc,
    "\n",
    md_links(unit$readings, "Readings", level = 2),
    md_supplements(unit$supplements, supp_index, level = 2)
  )
}

md_list <- function(x, title, level = 2) {
  if (length(x) == 0)
    return()

  paste0(
    md_heading(title, level = level),
    "\n",
    paste0("1. ", indent(x, by = 4, first = 0), "\n", collapse = ""),
    "\n"
  )
}

md_needs <- function(units, unit_index) {
  if (length(units) == 0)
    return()

  titles <- unit_index[units] %>% map_chr("title") %>% unname()
  links <- paste0("[", titles, "](", units, ".md)", collapse = ", ")

  paste0("<small>(Builds on: ", links, ")</small>")
}

md_leads <- function(slug, unit_index) {
  units <- unit_index %>%
    keep(~ slug %in% .$needs)

  if (length(units) == 0)
    return()

  titles <- units %>% map_chr("title") %>% unname()
  links <- paste0("[", titles, "](", names(units), ".md)", collapse = ", ")

  paste0("<small>(Leads to: ", links, ")</small>")
}
