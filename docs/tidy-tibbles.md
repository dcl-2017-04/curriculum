---
title: Tidy tibbles
---

<!-- Generated automatically from tidy-tibbles.yml. Do not edit by hand -->

# Tidy tibbles

Tidy data has variables in columns, and cases (or observations) in rows. So far
you've only worked with carefully prepared tidy tibbles. Now it's time to learn
more about the theory behind tidy data, and what exactly a tibble is.

## Readings

  * [Introduction](http://r4ds.had.co.nz/tibbles.html#introduction-4) [r4ds-10.1]

  * [Creating tibbles](http://r4ds.had.co.nz/tibbles.html#tibbles) [r4ds-10.2]

  * [Tidy data](http://r4ds.had.co.nz/tidy-data.html#tidy-data-1) [r4ds-12.2]


## Exercises
[Download `tidy-tibbles-exercises.Rmd`](tidy-tibbles-exercises.Rmd)


1.  Practice referring to non-syntactic names in the following data frame by:

    1.  Extracting the variable called `1`.

    2.  Plotting a scatterplot of `1` vs `2`.

    3.  Creating a new column called `3` which is `2` divided by `1`.

    4.  Renaming the columns to `one`, `two` and `three`.

    ``` r
    annoying <- tibble(
      `1` = 1:10,
      `2` = `1` * 2 + rnorm(length(`1`))
    )
    ```

2.  Compute the `rate` for `table2`, and `table4a` + `table4b`. You will need to perform four operations:

    1.  Extract the number of TB cases per country per year.
    2.  Extract the matching population per country per year.
    3.  Divide cases by population, and multiply by 10000.
    4.  Store back in the appropriate place.

    Which representation is easiest to work with? Which is hardest? Why?


