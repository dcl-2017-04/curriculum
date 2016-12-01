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
  html_node(xpath =" .//b/following-sibling::text()") %>%
  html_text(trim = TRUE)

chapters <- tibble(id, title, depth, href)

chapters %>%
  filter(!is.na(title), depth <= 2) %>%
  write_csv("books/r4ds.csv")
