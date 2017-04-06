write_if_different <- function(contents, path, check = TRUE) {
  if (!file.exists(dirname(path))) {
    dir.create(dirname(path), showWarnings = FALSE)
  }

  if (same_contents(path, contents)) return(FALSE)

  name <- basename(path)
  if (!str_detect(name, "^[a-zA-Z][a-zA-Z0-9_.-]*$")) {
    cat("Skipping invalid path: ", name, "\n")
    FALSE
  } else {
    cat(sprintf('Writing %s\n', name))
    writeLines(contents, path, useBytes = TRUE)
    TRUE
  }
}

same_contents <- function(path, contents) {
  if (!file.exists(path)) return(FALSE)

  contents <- paste0(paste0(contents, collapse = "\n"), "\n")
  if (.Platform$OS.type == "windows") {
    contents <- gsub("\n", "\r\n", contents, fixed = TRUE)
  }

  text_hash <- digest::digest(contents, serialize = FALSE)
  file_hash <- digest::digest(file = path)

  identical(text_hash, file_hash)
}
