library(tidyverse)
library(rvest)
library(stringr)

page <- read_html("https://www.rstudio.com/resources/cheatsheets/")

boxes <- page %>%
  html_node(".post-content") %>%
  html_nodes("div.fusion-layout-column")

title <- boxes %>%
  html_node("h2") %>%
  html_text() %>%
  str_replace_all("\\s", " ")

href <- boxes %>%
  html_node(".fusion-button-wrapper a") %>%
  html_attr("href")

id <- href %>%
  basename() %>%
  tools::file_path_sans_ext() %>%
  str_replace("-cheatsheet", "")

cheatsheets <- tibble(id, title, href)

cheatsheets %>%
  filter(!is.na(id), !is.na(title)) %>%
  filter(cumall(title != "Base R")) %>% # Remove contributed cheatsheets
  write_csv("books/cheatsheets.csv")
