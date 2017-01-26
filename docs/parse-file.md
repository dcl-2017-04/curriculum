---
title: Parsing files
---

<!-- Generated automatically from parse-file.yml. Do not edit by hand -->

# Parsing files

<small>(Builds on [Parsing vectors](parse-vector.md), [Tidy tibbles](tidy-tibbles.md))</small>

<small>(Leads to: [Exporting data](export.md))</small>

Now that you know how to parse character vectors, you can learn how to
parse complete files. This involves two new skills:

* Figuring out which `read_` function corresponds to your file format.
  (If you're stuck, looking at the first few lines with
  `read_lines("path", n_max = 10))` is often helpful)

* Understanding how readr's heuristics guess the type of each column,
  and how to translate you knowledge of the `parse_` functions to
  override those guesses when necessary.

## Readings

  * [Getting started](http://r4ds.had.co.nz/data-import.html#getting-started) [r4ds-11.2]

  * [Parsing a file](http://r4ds.had.co.nz/data-import.html#parsing-a-file) [r4ds-11.4]

  * [Data Import Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-import-cheatsheet.pdf) [cheatsheets-data-import]



