# Missing values

R uses `NA` to present unknown, but potentially measurable variables.

## Readings

  * [Missing values](http://r4ds.had.co.nz/exploratory-data-analysis.html#missing-values-2) [r4ds-7.4]

  * [Missing values](http://r4ds.had.co.nz/transform.html#missing-values) [r4ds-5.2.3]

  * [Missing values](http://r4ds.had.co.nz/transform.html#missing-values-1) [r4ds-5.6.2]

  * [Missing values](http://r4ds.had.co.nz/tidy-data.html#missing-values-3) [r4ds-12.5]


## Exercises

1.  If `x` is a numeric vector containing some missing values, what does
    `sum(x == NA)` return. Why? What does `mean(is.na(x))` return? Why?
    
1.  Create a function that replaces missing values with the mean of the
    remaining values.
    

## Supplemental readings

  * [naniar, by Nicholas Tierny](https://github.com/njtierney/naniar).
    This is an ggplot2 extension that adds comprehensive tools for visulising
    missing data.



