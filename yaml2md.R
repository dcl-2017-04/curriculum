library(tidyverse)
library(yaml)
source("utils.R")


# Markdown generation -----------------------------------------------------

md_page <- function(yaml) {
  parts <- yaml$parts %>% map_chr(md_part)

  paste0(
    "<!-- Generated automatically from index.yaml. Do not edit by hand -->\n",
    md_header(yaml),
    "\n",
    paste0(parts, collapse = "")
  )
}

md_header <- function(yaml, level = 1) {
  paste0(
    strrep("#", level), " ", yaml$title, "\n",
    "\n",
    yaml$desc
  )
}

md_part <- function(yaml, level = 2) {
  paste0(
    md_header(yaml, level = level),
    "\n",
    md_links(yaml$readings, "Readings"),
    md_links(yaml$challenges, "Challenges"),
    md_links(yaml$supplements, "Supplemental readings")
  )
}

md_links <- function(yaml, title) {
  if (is.null(yaml))
    return("")

  links <- yaml %>% map_chr(md_link)
  bullets <- paste0("* ", links, "\n")

  paste0(
    "### ", title, "\n",
    "\n",
    paste0(bullets, collapse = ""),
    "\n"
  )
}

md_link <- function(link) {
  if (has_name(link, "book")) {
    book <- find_book(link$book)

    href <- book$href
    text <- book$title
  } else if (has_name(link, "href")) {
    href <- link$href
    text <- link$text %||% href
  } else if (has_name(link, "todo")) {
    href <- NA
    text <- link$todo
  } else {
    stop("Unknown link type", call. = FALSE)
  }


  if (is.na(href)) {
    text
  } else {
    paste0("[", text, "](", href, ")")
  }
}


# Create READMEs ----------------------------------------------------------

build_readme <- function(path) {
  yaml <- yaml.load_file(file.path(path, "index.yml"))
  md <- md_page(yaml)

  cat(md, file = file.path(path, "README.md"))
}

paths <- dir(pattern = "^week-")
paths %>% walk(build_readme)
