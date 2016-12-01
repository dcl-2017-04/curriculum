library(tidyverse)
library(rvest)
library(stringr)

toc <- read_html("books/r4ds.html") %>% html_nodes(".chapter")

id <- toc %>%
  html_attr("data-level") %>%
  forcats::fct_inorder()
depth <- str_count(id, fixed(".")) + 1

href <- toc %>%
  html_node("a") %>%
  html_attr("href") %>%
  str_c("http://r4ds.had.co.nz/", .)

title <- toc %>%
  map_chr(. %>%
    html_nodes(xpath = "./a/node()[not(self::b)]") %>%
    html_text() %>%
    str_c(collapse = "") %>%
    str_trim()
  ) %>%
  paste0(" [R4DS]")


chapters <- tibble(id, title, depth, href)

chapters %>%
  filter(id != "", depth <= 2) %>%
  write_csv("books/r4ds.csv")
