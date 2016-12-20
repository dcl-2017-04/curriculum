# Data transformations

Transformation functions take one (or more) vectors and return a transformed
vector of the same length. They are often needed using your domain knowledge to
re-paramerising the data can make patterns more clear. Transformation are
important in visualisations, as sometimes you'll want to do a quick and dirty
transformation in the call to `aes()`. However, another important
transformation always occurs during visualisation: transformation from data to
visual properties. This is handled by the scales.

## Readings

  * [Useful creation functions](http://r4ds.had.co.nz/transform.html#mutate-funs) [r4ds-5.5.1]

    Make sure that you're familiar with the most important existing
    transformations.

  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6]
  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling]

    The cheatsheet includes a list of the most important transformation
    functions. Refer to it when you forget.


## Exercises

1.  Whenever your data includes a variable that could be calculated from other
    variables in your dataset, you should always recalculate it and compare.
    In the diamonds dataset, you could approximate `depth` from `x`, `y`, `z`
    
1.  You could also approximate `carat` using `x`, `y`, and `z`. Start your
    approximation by assuming that diamonds are cubes and computing the volume.
    How are the volume and weight related? Can you use a better geometric
    approximation? Can you approximate `carat` using the volume and the
    density of diamond?
    
1.  Log transforming `price` and `carat` makes the relationship between
    the two variables more clear (and suggests that there are a lot of missing
    expensive diamonds). There are at least three ways to perform this
    transformation. Brainstorm some approaches and briefly describe the pros
    and cons.
    
1.  List all related variables in `nycflights13::flights`.  Double check
    the value of `dep_delay`. Hint: you'll find the calculation easier if you
    compute "decimal hours", i.e. `hour + minutes / 60`. Rather than copying
    and pasting this calculation in multiple places, write a helper function.


