---
title: Data transformations
---

<!-- Generated automatically from data-transformations.yml. Do not edit by hand -->

# Data transformations

Transformation functions take one (or more) vectors and return a transformed
vector of the same length. They are often needed using your domain knowledge to
re-paramerising the data can make patterns more clear. Transformation are
important in visualisations, as sometimes you'll want to do a quick and dirty
transformation in the call to `aes()`. However, another important
transformation always occurs during visualisation: transformation from data to
visual properties. This is handled by the scales.

## Readings

  * [Useful creation functions](http://r4ds.had.co.nz/transform.html#mutate-funs) [r4ds-5.5.1].
    Make sure that you're familiar with the most important existing
    transformations.

  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6]

  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling].
    The cheatsheet includes a list of the most important transformation
    functions. Refer to it when you forget.



