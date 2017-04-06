
themes <- c("Explore", "Wrangle", "Program", "Model", "Communicate", "Workflow")


theme_index <- function(units) {
  unit_df <- tibble(
    unit = units %>% names(),
    title = units %>% map_chr("title"),
    theme = units %>% map_chr("theme"),
    link = glue::glue("* [{title}]({unit}.html)")
  ) %>% arrange(theme, title)


  theme_units <- themes %>% tolower() %>% map(~ filter(unit_df, theme == .))

  theme_links <- theme_units %>% map(~ paste(.$link, collapse = "\n"))

  paste0(
    "---\n",
    "title: Syllabus\n",
    "---\n",

    glue::glue("
      ## {themes} {{#{tolower(themes)}}}

      {theme_links}
    ") %>% collapse("\n\n")
  )
}

# Supplements -------------------------------------------------------------

supplements_index <- function(x) {
  slug <- x %>% map_chr("slug")
  supplements <- x %>%
    map_chr(md_supplement) %>%
    .[order(slug)]

  paste0(
    md_generated_by("supplements.yml"),
    "# Supplemental readings\n",
    "\n",
    paste(supplements, collapse = "")
  )
}

md_supplements <- function(x, index, level = 2) {
  if (length(x) == 0)
    return("")

  titles <- index[x] %>% map_chr("text") %>% unname()
  links <- paste0("* [", titles, "](supplements.html#", x, ")\n")

  paste0(
    md_heading("Supplemental readings", level = level),
    "\n",
    paste0(links, collapse = ""),
    "\n"
  )
}

md_supplement <- function(x) {

  if (has_name(x, "safari")) {
    x$href <- paste0(
      "http://proquest.safaribooksonline.com.ezproxy.stanford.edu",
      x$safari
    )
  }

  paste0(
    "## ", x$text, " {#", x$slug, "}\n",
    if (!is.null(x$author))
      paste0("by ", x$author, "\n"),
    "\n",
    "<", x$href, ">\n",
    "\n",
    indent(trimws(x$desc), 0, wrap = TRUE),
    "\n"
  )
}
