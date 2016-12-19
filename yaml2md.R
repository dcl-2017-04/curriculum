library(yaml)
library(tidyverse)
source("utils.R")


# Syllabus index -------------------------------------------------------
# lists each week, along with description

week_path <- function(i) sprintf("week-%02d.md", i)

syllabus_desc <- function(x, i) {
  paste0(
    "*   __Week ", i, "__: [", x$title, "](", week_path(i), ")\n",
    "\n",
    indent(x$desc, 4, wrap = TRUE)
  )
}

syllabus_index <- function(syllabus) {
  weeks <- syllabus %>%
    map2_chr(seq_along(.), syllabus_desc) %>%
    paste0("\n\n", collapse = "")

  paste0(
    md_generated_by("syllabus.yml"),
    "# Weekly syllabus\n",
    "\n",
    weeks
  )
}

# Weekly pages ------------------------------------------------------------

syllabus_week <- function(i, syllabus) {
  week <- syllabus[[i]]

  unit_names <- week$units
  if (length(unit_names) > 0) {
    unit_paths <- paste0("units/", unit_names, ".yml")
    units <- map(unit_paths, yaml.load_file)
  } else {
    units <- list()
  }

  paste0(
    md_generated_by("syllabus.yml"),
    "# ", week$title, " (Week ", i, ")\n",
    "\n",
    indent(week$desc, 0, wrap = TRUE),
    "\n",
    units %>%
      map_chr(md_unit) %>%
      paste0("\n", collapse = ""),

    md_challenges(week$challenges)

  )
}

md_unit <- function(unit) {
  paste0(
    "## ", unit$title, "\n",
    "\n",
    indent(unit$desc, 0, wrap = TRUE),
    "\n",
    md_links(unit$readings, "Readings"),
    md_links(unit$supplements, "Supplemental readings")
  )
}

md_challenges <- function(challenges) {
  if (length(challenges) == 0)
    return()

  paste0(
    "## Challenges\n",
    "\n",
    paste0("  * ", challenges, "\n", collapse = "\n"),
    "\n"
  )
}

# Markdown helpers -----------------------------------------------------

md_generated_by <- function(source) {
  paste0("<!-- Generated automatically from ", source, ". Do not edit by hand -->\n")
}

md_header <- function(yaml, level = 1) {
  paste0(
    strrep("#", level), " ", yaml$title, "\n",
    "\n",
    yaml$desc
  )
}

md_links <- function(yaml, title) {
  if (is.null(yaml))
    return("")

  paste0(
    "### ", title, "\n",
    "\n",
    yaml %>% map_chr(md_bullet) %>% paste0(collapse = "")
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
  text <- paste0("  * ", text, "\n")

  if (!is.null(yaml$desc)) {
    text <- paste0(
      text,
      "\n",
      indent(trimws(yaml$desc), 4, wrap = TRUE), "\n"
    )
  }

  text
}

# Create READMEs ----------------------------------------------------------

syllabus <- yaml.load_file("syllabus.yml")
syllabus_index(syllabus) %>% writeLines("syllabus/README.md")

weekly <- seq_along(syllabus) %>%
  map_chr(syllabus_week, syllabus = syllabus)

walk2(weekly, file.path("syllabus", week_path(seq_along(syllabus))), writeLines)

