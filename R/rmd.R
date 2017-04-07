render_rmd <- function(rmd_path) {
  md_path <- gsub("\\.Rmd$", ".md", rmd_path)
  yaml_path <- gsub("\\.Rmd$", ".yml", rmd_path)

  if (!out_of_date(rmd_path, yaml_path))
    return()

  callr::r_safe(
    function(...) rmarkdown::render(...),
    args = list(
      rmd_path,
      output_file = basename(md_path),
      output_format = rmarkdown::github_document(html_preview = FALSE),
      quiet = TRUE
    )
  )

  md <- read_file(md_path)
  on.exit(file.remove(md_path))

  meta <- rmarkdown::yaml_front_matter(rmd_path)

  yaml <- list(
    title = meta$unit_title,
    theme = meta$theme,
    needs = meta$needs,
    readings = meta$readings,
    desc = md
  )

  yaml %>%
    yaml::as.yaml() %>%
    write_if_different(yaml_path) %>%
    invisible()
}
