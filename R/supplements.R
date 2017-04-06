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
