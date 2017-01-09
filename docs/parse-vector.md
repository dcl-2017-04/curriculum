---
title: Parsing vectors
---

<!-- Generated automatically from parse-vector.yml. Do not edit by hand -->

# Parsing vectors

Importing a file take places in two steps:

1. The rectangular file is parsed into rows and columns. Each cell
   is a string.

2. We try to parsed each into a more specific type, like numeric or date.

It's easiest to learn import starting with step 2, because you can
practice parsing character vectors with toy data in R. This will be helpful
later when you encounter a weird file that needs special handling.

## Readings

  * [Parsing a vector](http://r4ds.had.co.nz/data-import.html#parsing-a-vector) [r4ds-11.3]



