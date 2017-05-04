---
title: Exporting data
---

<!-- Generated automatically from export.yml. Do not edit by hand -->

# Exporting data <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Parsing basics](parse-basics.md))</small>

There are three main reasons you might want to export a tibble from R:

* To share with others.

* To track changes over time using Git & GitHub.

* To cache partial results so you don't need to re-run a complete tidying
  work flow every time you restart your analysis.

Generally, csv is a good way to store data: it's simple, and can be
read by a large variety of tools (including GitHub which displays it nicely
online). However, it doesn't store some important metadata, and it's not
optimised for efficient reading. For those scenarios, you may want to use
RDS or feather files instead.

## Readings

  * [Writing to a file](http://r4ds.had.co.nz/data-import.html#writing-to-a-file) [r4ds-11.5]


