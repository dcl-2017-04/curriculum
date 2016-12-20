library(yaml)
library(tidyverse)
source("utils.R")

load_units <- function() {
  paths <- dir("units", full.name = TRUE)
  names(paths) <- tools::file_path_sans_ext(basename(paths))

  map(paths, yaml.load_file)
}

load_syllabus <- function() {
  yaml.load_file("syllabus.yml")
}

# Syllabus index -------------------------------------------------------
# lists each week, along with description

week_path <- function(i) sprintf("week-%02d.md", i)

syllabus_index <- function(syllabus) {
  weeks <- syllabus %>%
    map2_chr(seq_along(.), syllabus_desc) %>%
    paste0("\n", collapse = "")

  paste0(
    md_generated_by("syllabus.yml"),
    "# Weekly syllabus\n",
    "\n",
    weeks
  )
}

syllabus_desc <- function(x, i) {
  paste0(
    "## ", x$title, " <small>(Week ", i, ")</small>\n",
    "\n",
    indent(x$desc, 0, wrap = TRUE),
    "\n",
    syllabus_units(x, level = 3),
    syllabus_challenges(x, level = 3)
  )
}

syllabus_units <- function(x, level) {
  units <- x$units
  if (length(units) == 0)
    return()

  paste0(
    md_heading("Units", level = level),
    "\n",
    paste0("1. [", units, "](", units, ".md)\n", collapse = ""),
    "\n"
  )
}

syllabus_challenges <- function(x, level) {
  md_list(x$challenges, "Challenges", level = level)
}

# Weekly pages ------------------------------------------------------------

md_unit <- function(unit) {
  paste0(
    "# ", unit$title, "\n",
    if (!is.null(unit$duration))
      paste0("(estimated duration: ", unit$duration, " mins)\n"),
    "\n",
    indent(unit$desc, 0, wrap = TRUE),
    "\n",
    md_links(unit$readings, "Readings"),
    md_list(unit$exercises, "Exercises"),
    md_links(unit$supplements, "Supplemental readings")
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
