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

  paste0(
    "### ", title, "\n",
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
    id <- NA
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
    stop("Unknown yaml type", call. = FALSE)
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
      indent(trimws(yaml$desc), 4), "\n",
      "\n"
    )
  }

  text
}

# Create READMEs ----------------------------------------------------------

build_readme <- function(path) {
  yaml <- yaml.load_file(file.path(path, "index.yml"))
  md <- md_page(yaml)

  cat(md, file = file.path(path, "README.md"))
}
