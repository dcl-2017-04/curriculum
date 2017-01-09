read_yaml <- function(path) {
  tryCatch(
    yaml::yaml.load_file(path),
    error = function(e) {
      stop(
        "Problem loading ", path, "\n",
        e$message,
        call. = FALSE)
    }
  )
}

load_units <- function() {
  paths <- dir("units", pattern = "\\.yml$", full.name = TRUE)
  names(paths) <- tools::file_path_sans_ext(basename(paths))

  map(paths, read_yaml)
}

load_syllabus <- function() {
  read_yaml("syllabus.yml")
}

load_supplements <- function() {
  x <- read_yaml("supplements.yml")
  x %>%
    set_names(x %>% map_chr("slug"))
}


has_name <- function(x, nm) {
  if (is.null(names(x)))
    return(FALSE)

  nm %in% names(x)
}

`%||%` <- function(x, y) if (is.null(x)) y else x


books <- read_csv(
  "books/books.csv",
  col_types = cols(
    id = col_character(),
    title = col_character(),
    href = col_character(),
    depth = col_integer()
  )
)

find_book <- function(x) {
  match <- books$id == x
  if (!any(match)) {
    stop("Couldn't find book: '", x, "'", call. = FALSE)
  }

  as.list(books[match, , drop = FALSE])
}

indent <- function(text, by = 2, first = by, wrap = FALSE) {
  if (wrap) {
    wrapped <- strwrap(text, width = 80, indent = first, exdent = by)
    paste0(wrapped, "\n", collapse = "")
  } else {
    paste(strrep(" ", first), gsub("\n", paste0("\n", strrep(" ", by)), text))
  }
}
