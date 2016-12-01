library(tidyverse)
library(rvest)
library(stringr)


page <- read_html("https://www.rstudio.com/resources/cheatsheets/")

boxes <- page %>%
  html_node(".post-content") %>%
  html_nodes("div.fusion-layout-column")

title <- boxes %>%
  html_node("h2") %>%
  html_text()

url <- boxes %>%
  html_node(".fusion-button-wrapper a") %>%
  html_attr("href")

name <- url %>%
  basename() %>%
  tools::file_path_sans_ext() %>%
  str_replace("-cheatsheet", "")

cheatsheets <- tibble(name, title, url)

cheatsheets %>%
  filter(!is.na(name), !is.na(title)) %>%
  write_csv("books/cheatsheets.csv")
