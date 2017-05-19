---
title: Scoped verbs
---

<!-- Generated automatically from manip-scoped.yml. Do not edit by hand -->

# Scoped verbs <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Iteration](iteration.md), [Manipulation basics](manip-basics.md))</small>  
<small>(Leads to: [Programming dplyr](manip-programming.md))</small>


dplyr 0.6.0
-----------

First, make sure you have the latest version of dplyr, 0.6.0. You can check what version you currently have with `packageVersion()`:

``` r
packageVersion("dplyr")
#> [1] '0.6.0'
```

If you're version is older, use `install.packages()` to update it.

Scoped verbs
------------

In this version of dplyr each of the single table verbs comes in three additional forms, `_if`, `_at`, and `_all`. You can use these forms to affect multiple variables at once.

-   `_if` allows you to pick variables based on a predicate function like `is.numeric()` or `is.character()`

-   `_at` allows you to pick variables using the same syntax as `select()`.

-   `_all` operates on all variables.

I'll illustrate the three variants in detail for `summarise()`, then explore in less detail how you can use similar techniques with `mutate()` and `filter()`. You'll need the scoped variants of the other verbs less frequently, but when you do, it should be straightforward to generalise what you learn here.

Summarise
---------

### `summarise_all()`

The simplest variant to understand is `summarise_all()`. It takes a tibble and a function and applies that function to each column:

``` r
df <- tibble(
  x = runif(100),
  y = runif(100),
  z = runif(100)
)
summarise_all(df, mean)
#> # A tibble: 1 x 3
#>           x         y        z
#>       <dbl>     <dbl>    <dbl>
#> 1 0.5015599 0.5051272 0.525713
```

If you want to apply multiple summaries, use the `funs()` helper:

``` r
summarise_all(df, funs(min, max))
#> # A tibble: 1 x 6
#>        x_min      y_min       z_min     x_max     y_max    z_max
#>        <dbl>      <dbl>       <dbl>     <dbl>     <dbl>    <dbl>
#> 1 0.02678868 0.01558136 0.001738437 0.9931423 0.9994385 0.971078
```

### `summarise_at()`

`summarise_at()` allows you to pick columns in the same way as `select()`, i.e. based on their names. There is one small different: you need to wrap your complete selection with the `vars()` helper.

``` r
summarise_at(df, vars(-z), mean)
#> # A tibble: 1 x 2
#>           x         y
#>       <dbl>     <dbl>
#> 1 0.5015599 0.5051272
```

By default, the newly created columns have the shortest names needed to uniquely identify the output.

``` r
summarise_at(df, vars(x), funs(min, max))
#> # A tibble: 1 x 2
#>          min       max
#>        <dbl>     <dbl>
#> 1 0.02678868 0.9931423
summarise_at(df, vars(x, y), min)
#> # A tibble: 1 x 2
#>            x          y
#>        <dbl>      <dbl>
#> 1 0.02678868 0.01558136
summarise_at(df, vars(-z), funs(min, max))
#> # A tibble: 1 x 4
#>        x_min      y_min     x_max     y_max
#>        <dbl>      <dbl>     <dbl>     <dbl>
#> 1 0.02678868 0.01558136 0.9931423 0.9994385
```

### `summarise_if()`

`summarise_at()` allows you to pick variables to summarise based on their name. `summarise_if()` allows you to pick variables to summarise based on some property of the column. Typically this is their type:

``` r
starwars %>%
  group_by(species) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)
#> # A tibble: 38 x 4
#>    species height  mass birth_year
#>      <chr>  <dbl> <dbl>      <dbl>
#> 1   Aleena     79    15        NaN
#> 2 Besalisk    198   102        NaN
#> 3   Cerean    198    82         92
#> 4 Chagrian    196   NaN        NaN
#> 5 Clawdite    168    55        NaN
#> # ... with 33 more rows
```

(Note that `na.rm = TRUE` is passed on to `mean` function, in the same way that purrr's map functions work.)

Mutate
------

`mutate_all()`, `mutate_if()` and `mutate_at()` work in a similar way to their summarise equivalents.

``` r
mutate_all(df, log10)
#> # A tibble: 100 x 3
#>             x           y          z
#>         <dbl>       <dbl>      <dbl>
#> 1 -0.21548947 -0.02245562 -1.0205839
#> 2 -0.04342863 -0.27775394 -0.1709073
#> 3 -0.41855041 -0.79840673 -1.7208237
#> 4 -0.51645250 -0.23363738 -1.2447004
#> 5 -0.23125750 -0.25416291 -0.2589710
#> # ... with 95 more rows
```

Rather than creating functions with `~` (like in purrr), you can create shortcuts directly inside funs:

``` r
mutate_all(df, funs(round(. * 25)))
#> # A tibble: 100 x 3
#>       x     y     z
#>   <dbl> <dbl> <dbl>
#> 1    15    24     2
#> 2    23    13    17
#> 3    10     4     0
#> 4     8    15     1
#> 5    15    14    14
#> # ... with 95 more rows
```

The default names are generated in the same way as `summarise()`. That means that you may want to use a `transmute()` variant if you want to apply multiple transformations and don't want the original values:

``` r
mutate_all(df, funs(log, double = . * 2))
#> # A tibble: 100 x 9
#>           x         y          z       x_log       y_log      z_log
#>       <dbl>     <dbl>      <dbl>       <dbl>       <dbl>      <dbl>
#> 1 0.6088503 0.9496080 0.09537094 -0.49618284 -0.05170598 -2.3499814
#> 2 0.9048391 0.5275287 0.67467203 -0.09999812 -0.63955208 -0.3935286
#> 3 0.3814605 0.1590718 0.01901850 -0.96374794 -1.83839944 -3.9623430
#> 4 0.3044721 0.5839325 0.05692455 -1.18917583 -0.53796996 -2.8660286
#> 5 0.5871411 0.5569768 0.55084449 -0.53249008 -0.58523172 -0.5963027
#> # ... with 95 more rows, and 3 more variables: x_double <dbl>,
#> #   y_double <dbl>, z_double <dbl>
transmute_all(df, funs(log, double = . * 2))
#> # A tibble: 100 x 6
#>         x_log       y_log      z_log  x_double  y_double  z_double
#>         <dbl>       <dbl>      <dbl>     <dbl>     <dbl>     <dbl>
#> 1 -0.49618284 -0.05170598 -2.3499814 1.2177006 1.8992161 0.1907419
#> 2 -0.09999812 -0.63955208 -0.3935286 1.8096782 1.0550573 1.3493441
#> 3 -0.96374794 -1.83839944 -3.9623430 0.7629210 0.3181437 0.0380370
#> 4 -1.18917583 -0.53796996 -2.8660286 0.6089442 1.1678649 0.1138491
#> 5 -0.53249008 -0.58523172 -0.5963027 1.1742822 1.1139536 1.1016890
#> # ... with 95 more rows
```

Filter
------

`filter_all()` is the most useful of the three. You always use it conjunction with `all_vars()` or `any_vars()` depending on whether or not you want rows where all variables meet the criterion, or where just one variable meets it.

It's particularly useful finding missing values:

``` r
library(nycflights13)

filter_all(weather, any_vars(is.na(.)))
#> # A tibble: 3,109 x 15
#>   origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
#>    <chr> <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
#> 1    EWR  2013     1     1    17 39.20  28.4 64.93      270   16.11092
#> 2    EWR  2013     1     1    18 39.20  28.4 64.93      330   14.96014
#> 3    EWR  2013     1     3    16 30.92  14.0 49.01       NA    4.60312
#> 4    EWR  2013     1     6    10 33.80  30.2 86.49      210    4.60312
#> 5    EWR  2013     1     6    12 33.80  32.0 93.03      220    9.20624
#> # ... with 3,104 more rows, and 5 more variables: wind_gust <dbl>,
#> #   precip <dbl>, pressure <dbl>, visib <dbl>, time_hour <dttm>
```
