---
title: Separate and unite
---

<!-- Generated automatically from separate-unite.yml. Do not edit by hand -->

# Separate and unite <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Tidy data](tidy-data.md), [Regular expressions](regexps.md))</small>

`tidyr::separate()` is a useful tool for handling another common type of
messiness: when multiple variables are crammed into a single column.
Here you'll learn how to use `separate()` to pull them out into their own
columns.

The `sep` argument to `separate()` is a regular expression, which gives
you a lot of power. You might also want to read about `extract()`:
`str_split()` is to `separate()` as `str_match()` is to `extract().

The inverse of `separate()` is `unite()`. You use it when you have a variable
that is spread across multiple columns. This happens much less commonly.

## Readings

  * [Separating and uniting](http://r4ds.had.co.nz/tidy-data.html#separating-and-uniting) [r4ds-12.4]


