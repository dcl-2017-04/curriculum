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
