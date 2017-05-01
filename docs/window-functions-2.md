---
title: Vectorised functions
---

<!-- Generated automatically from window-functions-2.yml. Do not edit by hand -->

# Vectorised functions <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Manipulation basics](manip-basics.md))</small>


`summarise()` and `mutate()` work at the data frame level: they take a data frame as input and return a data frame as output. You combine these data frame function with with vector functions: functions that take a vector as input and return a vector as output. `summarise()` and `mutate()` have different constraints on the type of vector functions that they work with:

-   `summarise()` works with **summary** functions; functions that take `n` inputs and return a single output. This includes functions like `sum()` and `mean()` for numeric vectors; `all()` and `any()` for logical vectors; and `str_c()` with `collapse` for character vectors.

-   `mutate()` works with **transformation** functions: functions that take `n` inputs and return `n` outputs. So far you've mainly used vectorised maps, like `-` and `+`, or `&` and `|`. In this unit, you'll learn some finer details of these functions, and learn a new class of functions called **window functions**.

``` r
library(tidyverse)
```

Vectorised map functions
------------------------

A unary vectorised map takes a vector `x` and return a new vector `z` with two constraints:

1.  `z` is the same length of `x`.

2.  The value of `z[i]` only depends on `x[i]`.

Let's unpack the name of this class of function to better understand :

-   **Unary** means that it takes a single argument.

-   **Vectorised** means that the output is the same size as the input.

-   **Map** is a mathematical term that means that you can independent compute each pieces of the output from the corresponding piece of the input.

The diagram below shows a graphical depiction of such a function. The input, `x`, is on the left, and the output, `z` is on the right.

<img src="diagrams/map.png" width="126" />

This definition includes many mathematical functions like `log()` and `abs()`.

More useful, however, are the **binary** vectorised functions. These take two inputs `x` and `y`, and return a vector `z`, with the same constraints as above. This class of functions includes the very useful mathematical operators like `-`, `+`, `/`, `*`, `%%` and `%/%`. You've used these a lot already.

One fact that you've probably taken advantage of but might not have thought about explicitly, is what happens if the inputs are different lengths? For example, in `x * 2` below, `x` has length 5, but `y` has length 1.

``` r
x <- sample(100, 10)
y <- 2

x * y
#>  [1]  96  44 152 104 190  60   8  40  82 132
```

R has a special set of rules to cover this situation, the so-called **recycling rules**. Whenever you call a binary operator with inputs of different lengths, R will recycle the shorter vector to be the same length as the longer.

This is particularly useful when combined with summary operators:

``` r
x - min(x)
#>  [1] 44 18 72 48 91 26  0 16 37 62
(x - mean(x)) / sd(x)
#>  [1]  0.0929996 -0.8369964  1.0945337  0.2360759  1.7741462 -0.5508438
#>  [7] -1.4808398 -0.9085345 -0.1573839  0.7368430
```

(You can use recycling rules with vectors that are not of length 1, but that makes it easy to write confusing code, so I don't recommend it.)

Vectorised window functions
---------------------------

A vectorised map function can be generalised to vectorised **window** functions. In a window function the output no depends on a contiguous window of values (i.e. a sequence with no gaps). Map functions are a special case of window functions because in a map function, the "window" is just a single value.

### Offset

The simplest type of window is just an offset. Each output value still depends on only a single input value, but the input and output are no longer aligned.

<img src="diagrams/offset.png" width="281" />

In dplyr you can use `lead()` (positive) and `lag()` (negative) to look at offsets.

``` r
tibble(
  x = 1:5,
  pos = lead(x),
  neg = lag(x)
)
#> # A tibble: 5 × 3
#>       x   pos   neg
#>   <int> <int> <int>
#> 1     1     2    NA
#> 2     2     3     1
#> 3     3     4     2
#> 4     4     5     3
#> 5     5    NA     4
```

You can change the number of positions to look ahead or behind with the second argument, `n`.

Remember that these are vectorised functions, so the output must be the same length as the input. That means we need to pad either the beginning or the end of the vector. `lead()` and `lag()` pad with `NA` but you can change this value with the `default` argument.

``` r
tibble(
  x = 1:5,
  pos = lead(x, default = 0),
  neg = lag(x, default = 0)
)
#> # A tibble: 5 × 3
#>       x   pos   neg
#>   <int> <dbl> <dbl>
#> 1     1     2     0
#> 2     2     3     1
#> 3     3     4     2
#> 4     4     5     3
#> 5     5     0     4
```

`lead()` and `lag()` are very useful when combined with a binary vectorised map:

-   `x == lag(x)` tells you if `x` has changed compared to the previous value.

-   `x - lag(x)` tells you how `x` has changed.

### Rolling

Rolling window functions are the next step up in complexity. Instead of a window of size one, they now have a window of size `m`.

<img src="diagrams/rolling.png" width="151" />

Neither base R not dplyr provide rolling functions, but you can get them from the RcppRoll package. By default the `roll_` functions are not vectorised (they return shorter vectors), but you can make them vectorised by setting `fill = NA`.

``` r
library(RcppRoll)

tibble(
  x = 1:5,
  roll_sum = roll_sum(x, 2, fill = NA),
  roll_mean = roll_mean(x, 2, fill = NA)
)
#> # A tibble: 5 × 3
#>       x roll_sum roll_mean
#>   <int>    <dbl>     <dbl>
#> 1     1        3       1.5
#> 2     2        5       2.5
#> 3     3        7       3.5
#> 4     4        9       4.5
#> 5     5       NA        NA
```

You can control how the window is aligned to the data with the `align` argument.

### Cumulative

Cumulative functions are even more complex because the window size is no longer fixed. A cumulative function uses all values up to the current position.

<img src="diagrams/cumulative.png" width="126" />

Base R includes the cumulative functions `cumsum()`, `cumprod()`, `cummax()`, and `cummin()`. dplyr provides a few others: `cummean()`, `cumany()`, `cumall()`.

``` r
library(RcppRoll)

tibble(
  x = 1:5,
  cumsum = cumsum(x),
  cummean = cummean(x)
)
#> # A tibble: 5 × 3
#>       x cumsum cummean
#>   <int>  <int>   <dbl>
#> 1     1      1     1.0
#> 2     2      3     1.5
#> 3     3      6     2.0
#> 4     4     10     2.5
#> 5     5     15     3.0
```

### Complete

The most complex type of window function is the **complete** window function, where every output value depends on every input value.

<img src="diagrams/complete.png" width="126" />

This class of window function includes all the ranking functions, because the rank of any value depends on the rank of all the other values. There are three key ranking functions that differ in how ties are handled:

``` r
tibble(
  x = c(3, 3, 3, 2, 2, 1),
  min = min_rank(x),
  dense = dense_rank(x),
  row_number = row_number(x)
)
#> # A tibble: 6 × 4
#>       x   min dense row_number
#>   <dbl> <int> <int>      <int>
#> 1     3     4     3          4
#> 2     3     4     3          5
#> 3     3     4     3          6
#> 4     2     2     2          2
#> 5     2     2     2          3
#> 6     1     1     1          1
```

### Ordering

So far we've dodged the question of what we mean by "before" and "after", relying on the order of the rows. There are three ways to be more precise:

-   `arrange()` the data so you know exactly how the rows are ordered.

-   Use the `order_by` argument (if present), to order by a specific variable. This is more efficient than `arrange()` if you're only computing a single window function.

-   Use the `order_by()` helper if there is no `order_by` argument.
