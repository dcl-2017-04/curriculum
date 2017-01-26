library(yaml)
library(tidyverse)
source("utils.R")

# Syllabus index -------------------------------------------------------
# lists each week, along with description

syllabus_index <- function(syllabus, unit_index, supp_index) {
  weeks <- syllabus %>%
    map2_chr(
      seq_along(.),
      syllabus_desc,
      unit_index = unit_index,
      supp_index = supp_index
    ) %>%
    paste0("\n", collapse = "")

  paste0(
    md_generated_by("syllabus.yml"),
    weeks
  )
}

syllabus_desc <- function(x, i, unit_index, supp_index) {
  paste0(
    "## ", x$title, " {#", x$slug, "}\n",
    "\n",
    indent(x$desc, 0, wrap = TRUE),
    "\n",
    syllabus_units(x, unit_index, level = 3),
    syllabus_challenges(x, level = 3),
    md_supplements(x$supplements, supp_index, level = 3)
  )
}

syllabus_toc <- function(syllabus) {
  bullets <- map_chr(
    syllabus,
    ~ sprintf("<li><a href='{{ '/#%s' | relative_url }}'>%s</a></li>\n", .$slug, .$title)
  )

  paste0(
    "<h2>Contents</h2>\n",
    "<ul>\n",
    paste0(bullets, collapse = ""),
    "</ul>"
  )
}


syllabus_units <- function(x, index, level) {
  units <- x$units
  if (length(units) == 0)
    return()

  titles <- index[units] %>% map_chr("title") %>% unname()
  links <- paste0("1. [", titles, "](", units, ".md)\n", collapse = "")

  paste0(
    md_heading("Units", level = level),
    "\n",
    links,
    "\n"
  )
}

syllabus_challenges <- function(x, level) {
  md_list(x$challenges, "Challenges", level = level)
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


# Exercises ---------------------------------------------------------------

build_exercise <- function(unit_name, level = 2) {
  path <- paste0("units/", unit_name, ".Rmd")
  if (!file.exists(path))
    return()

  name <- paste0(unit_name, "-exercises.Rmd")

  rmd_path <- file.path("docs", name)
  file.copy(path, rmd_path)

  # Render to docs to create figures etc
  md_path <- rmarkdown::render(rmd_path,
    output_format = rmarkdown::github_document(
      fig_width = 6,
      fig_height = 6 / 1.618
    ),
    quiet = TRUE
  )

  # return as string then delete
  md <- read_file(md_path)
  unlink(md_path)

  paste0(
    md_heading("Exercises", level = level),
    "[Download `", name, "`](", name, ")\n",
    "\n",
    md,
    "\n"
  )
}

# Weekly pages ------------------------------------------------------------

md_unit <- function(unit, unit_name, unit_index, supp_index) {
  paste0(
    "---\n",
    "title: ", unit$title, "\n",
    "---\n",
    "\n",
    md_generated_by(paste0(unit_name, ".yml")),
    "# ", unit$title, "\n",
    "\n",
    md_needs(unit$needs, unit_index),
    "\n",
    md_leads(unit_name, unit_index),
    "\n",
    unit$desc,
    "\n",
    md_links(unit$readings, "Readings", level = 2),
    build_exercise(unit_name),
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

  paste0("<small>(Builds on ", links, ")</small>\n")
}

md_leads <- function(slug, unit_index) {
  units <- unit_index %>%
    keep(~ slug %in% .$needs)

  if (length(units) == 0)
    return()

  titles <- units %>% map_chr("title") %>% unname()
  links <- paste0("[", titles, "](", names(units), ".md)", collapse = ", ")

  paste0("<small>(Leads to: ", links, ")</small>\n")
}


# Markdown helpers -----------------------------------------------------

md_generated_by <- function(source) {
  paste0(
    "<!-- Generated automatically from ", source, ". Do not edit by hand -->\n",
    "\n"
  )
}

md_heading <- function(x, level = 1) {
  paste0(strrep("#", level), " ", x, "\n")
}

md_links <- function(yaml, title, level = 2) {
  if (is.null(yaml))
    return("")

  paste0(
    md_heading(title, level = level),
    "\n",
    yaml %>% map_chr(md_bullet) %>% paste0(collapse = ""),
    "\n"
  )
}

md_bullet <- function(yaml) {
  if (has_name(yaml, "book")) {
    book <- find_book(yaml$book)

    href <- book$href
    text <- book$title
    id <- book$id
  } else if (has_name(yaml, "href")) {
    href <- yaml$href
    text <- yaml$text %||% href
    id <- yaml$id %||% NA
  } else if (has_name(yaml, "todo")) {
    href <- NA
    text <- yaml$todo
    id <- "TODO"
  } else if (has_name(yaml, "safari")) {
    href <- paste0(
      "http://proquest.safaribooksonline.com.ezproxy.stanford.edu",
      yaml$safari
    )
    text <- yaml$text
    id <- "safari"
  } else if (has_name(yaml, "text")) {
    return(paste0(indent(yaml$text, 0, wrap = TRUE), "\n"))
  } else {
    stop(
      "Unknown yaml type: ", paste(names(yaml), collapse = "/"),
      call. = FALSE
    )
  }


  if (!is.na(href)) {
    text <- paste0("[", text, "](", href, ")")
  }
  if (!is.na(id)) {
    text <- paste0(text, " [", id, "]")
  }
  text <- paste0("  * ", text)

  if (!is.null(yaml$desc)) {
    text <- paste0(
      text,
      ".\n",
      indent(trimws(yaml$desc), 4, wrap = TRUE),
      "\n"
    )
  } else {
    text <- paste0(text, "\n\n")
  }

  text
}
