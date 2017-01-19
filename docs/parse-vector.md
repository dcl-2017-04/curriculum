---
title: Parsing vectors
---

<!-- Generated automatically from parse-vector.yml. Do not edit by hand -->

# Parsing vectors

Importing a file takes place in two steps:

1. The rectangular file is parsed into rows and columns. Each cell
   is a string.

2. We parse each column of strings into a more specific type, like
   numeric or date.

For example, take the following (very simple) csv file:

```
a,b,c
x,4,5.4
y,NA,7.2
```

It's first parsed into individual cells, forming a tibble where each
column is a character vector:

```R
tibble(
  a = c("x", "y"),
  b = c("4", "NA"),
  c = c("5.4, "7.2")
)
```

Then, where possible, each column is parsed into a more specific type:

```R
tibble(
  a = c("x", "y"),
  b = c(4L, NA),
  c = c(5.4, 7.2)
)
```

(The `L` suffix indicates that we have the integer 4, not the real nubmer
4. You'll learn more about that later.)

You'll learn import starting with step 2, because you can practice parsing
character vectors with toy data in R. This will be helpful later when you
encounter a weird file that needs special handling.

## Readings

  * [Parsing a vector](http://r4ds.had.co.nz/data-import.html#parsing-a-vector) [r4ds-11.3]



