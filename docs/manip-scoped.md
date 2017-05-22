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

(If you're using the development version, version 0.5.0.9005 is also ok.)

If you're version is older, use `install.packages()` to update it.

Scoped verbs
------------

In the latest version of dplyr each of the single table verbs comes in three additional forms with the suffixes `_if`, `_at`, and `_all`. These **scoped** variants allow you to affect multiple variables at once:

-   `_if` allows you to pick variables based on a predicate function like `is.numeric()` or `is.character()`.

-   `_at` allows you to pick variables using the same syntax as `select()`.

-   `_all` operates on all variables.

I'll illustrate the three variants in detail for `summarise()`, then explore in less detail how you can use similar techniques with `mutate()` and `filter()`. You'll need the scoped variants of the other verbs less frequently, but when you do, it should be straightforward to generalise what you've learn here.

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
#>           x         y         z
#>       <dbl>     <dbl>     <dbl>
#> 1 0.4988208 0.4958316 0.4884982
```

If you want to apply multiple summaries, use the `funs()` helper:

``` r
summarise_all(df, funs(min, max))
#> # A tibble: 1 x 6
#>        x_min      y_min        z_min     x_max     y_max     z_max
#>        <dbl>      <dbl>        <dbl>     <dbl>     <dbl>     <dbl>
#> 1 0.02158489 0.01370707 0.0001103689 0.9989331 0.9968572 0.9876778
```

There are two slightly inconsistent ways to use an inline function (this inconistency will get ironed out in a future version).

``` r
# For a single function, use ~ 
summarise_all(df, ~ sd(.) / mean(.))
#> # A tibble: 1 x 3
#>           x       y        z
#>       <dbl>   <dbl>    <dbl>
#> 1 0.5820303 0.57859 0.593545

# For multiple functions, use funs(), dropping the ~
# Typically you'll want to name the function so you get reasonable
# variable names.
summarise_all(df, funs(cv = sd(.) / mean(.), mean))
#> # A tibble: 1 x 6
#>        x_cv    y_cv     z_cv    x_mean    y_mean    z_mean
#>       <dbl>   <dbl>    <dbl>     <dbl>     <dbl>     <dbl>
#> 1 0.5820303 0.57859 0.593545 0.4988208 0.4958316 0.4884982
```

### `summarise_at()`

`summarise_at()` allows you to pick columns in the same way as `select()`, that is, based on their names. There is one small difference: you need to wrap the complete selection with the `vars()` helper (this avoids ambiguity).

``` r
summarise_at(df, vars(-z), mean)
#> # A tibble: 1 x 2
#>           x         y
#>       <dbl>     <dbl>
#> 1 0.4988208 0.4958316
```

By default, the newly created columns have the shortest names needed to uniquely identify the output.

``` r
summarise_at(df, vars(x), funs(min, max))
#> # A tibble: 1 x 2
#>          min       max
#>        <dbl>     <dbl>
#> 1 0.02158489 0.9989331
summarise_at(df, vars(x, y), min)
#> # A tibble: 1 x 2
#>            x          y
#>        <dbl>      <dbl>
#> 1 0.02158489 0.01370707
summarise_at(df, vars(-z), funs(min, max))
#> # A tibble: 1 x 4
#>        x_min      y_min     x_max     y_max
#>        <dbl>      <dbl>     <dbl>     <dbl>
#> 1 0.02158489 0.01370707 0.9989331 0.9968572
```

See the examples in the documentation if you want to force names when they're not otherwise needed.

### `summarise_if()`

`summarise_at()` allows you to pick variables to summarise based on their name. `summarise_if()` allows you to pick variables to summarise based on some property of the column. Typically this is their type because you want to (e.g.) apply a numeric summary function only to numeric columns:

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

(Note that `na.rm = TRUE` is passed on to `mean()` in the same way as in `purrr::map()`.)

Mutate
------

`mutate_all()`, `mutate_if()` and `mutate_at()` work in a similar way to their summarise equivalents.

``` r
mutate_all(df, log10)
#> # A tibble: 100 x 3
#>            x           y           z
#>        <dbl>       <dbl>       <dbl>
#> 1 -0.9964132 -0.30829179 -0.26830697
#> 2 -0.1854723 -0.06659310 -2.50156742
#> 3 -1.6658503 -1.09221172 -0.09240945
#> 4 -0.7636854 -0.08072301 -0.44019999
#> 5 -1.0824352 -0.12487100 -0.89412433
#> # ... with 95 more rows
```

Often you'll want to use an inline expression. As above, either use `~` for a single function or `funs()` for multiple functions:

``` r
mutate_all(df, ~ round(. * 25))
#> # A tibble: 100 x 3
#>       x     y     z
#>   <dbl> <dbl> <dbl>
#> 1     3    12    13
#> 2    16    21     0
#> 3     1     2    20
#> 4     4    21     9
#> 5     2    19     3
#> # ... with 95 more rows
mutate_all(df, funs(half = . / 2, double = . * 2))
#> # A tibble: 100 x 9
#>            x          y           z     x_half     y_half      z_half
#>        <dbl>      <dbl>       <dbl>      <dbl>      <dbl>       <dbl>
#> 1 0.10082932 0.49170906 0.539129417 0.05041466 0.24585453 0.269564709
#> 2 0.65242062 0.85784120 0.003150885 0.32621031 0.42892060 0.001575443
#> 3 0.02158489 0.08087016 0.808333452 0.01079244 0.04043508 0.404166726
#> 4 0.17231163 0.83038022 0.362910899 0.08615582 0.41519011 0.181455449
#> 5 0.08271130 0.75011698 0.127607344 0.04135565 0.37505849 0.063803672
#> # ... with 95 more rows, and 3 more variables: x_double <dbl>,
#> #   y_double <dbl>, z_double <dbl>
```

The default names are generated in the same way as `summarise()`. That means that you may want to use a `transmute()` variant if you want to apply multiple transformations and don't want the original values:

``` r
transmute_all(df, funs(half = . / 2, double = . * 2))
#> # A tibble: 100 x 6
#>       x_half     y_half      z_half   x_double  y_double   z_double
#>        <dbl>      <dbl>       <dbl>      <dbl>     <dbl>      <dbl>
#> 1 0.05041466 0.24585453 0.269564709 0.20165863 0.9834181 1.07825883
#> 2 0.32621031 0.42892060 0.001575443 1.30484125 1.7156824 0.00630177
#> 3 0.01079244 0.04043508 0.404166726 0.04316977 0.1617403 1.61666690
#> 4 0.08615582 0.41519011 0.181455449 0.34462326 1.6607604 0.72582180
#> 5 0.04135565 0.37505849 0.063803672 0.16542259 1.5002340 0.25521469
#> # ... with 95 more rows
```

Filter
------

`filter_all()` is the most useful of the three `filter()` variants. You use it conjunction with `all_vars()` or `any_vars()` depending on whether or not you want rows where all variables meet the criterion, or where just one variable meets it.

It's particularly useful finding missing values:

``` r
library(nycflights13)

# Rows where any value is missing
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

# Rows where all wind variables are missing
filter_at(weather, vars(starts_with("wind")), all_vars(is.na(.)))
#> # A tibble: 3 x 15
#>   origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
#>    <chr> <dbl> <dbl> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
#> 1    EWR  2013     3    27    21 51.98 19.04 27.02       NA         NA
#> 2    JFK  2013     7     4    10 73.04 71.06 93.52       NA         NA
#> 3    JFK  2013     7    20    10 80.96 71.06 71.92       NA         NA
#> # ... with 5 more variables: wind_gust <dbl>, precip <dbl>,
#> #   pressure <dbl>, visib <dbl>, time_hour <dttm>
```

