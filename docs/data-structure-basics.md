---
title: Data structure basics
---

<!-- Generated automatically from data-structure-basics.yml. Do not edit by hand -->

# Data structure basics <small class='program'>[program]</small>
<small>(Builds on: [Manipulation basics](manip-basics.md))</small>  
<small>(Leads to: [Date/time basics](datetime-basics.md), [Function basics](function-basics.md), [Lists](lists.md), [Parsing basics](parse-basics.md), [Atomic vectors](vectors.md))</small>


It's helpful to know a little bit about how data structures are organised in R. The simplest data structure in R is the vector, which can be broken up in to atomic vectors and augmented vectors. Vectors of related data are organised together in tibbles and data.frames.

``` r
library(tidyverse)
```

Atomic vectors
--------------

The atomic vectors are the "atoms" of R, the simple building blocks upon which all else is built. There are four types of atomic vector that are important for data analysis:

-   **logical** vectors `<lgl>` contain `TRUE` or `FALSE`.
-   **integer** vectors `<int>` contain integers.
-   **double** vectors `<dbl>` contain real numbers.
-   **character** vector `<chr>` contain strings made with `""`.

All vectors can also contain the missing value `NA`. You'll learn more about missing values later on. Collectively integer and double vectors are known as **numeric** vectors. The difference is rarely important in R.

You create atomic vectors by hand with the `c()` function:

``` r
logical <- c(TRUE, FALSE, FALSE)

# The difference between the real number 1 and the integer 1 is not 
# usually important, but it sometimes comes up. R uses the suffix 
# "L" to indicate that a number is an integer.
integer <- c(1L, 2L, 3L)

double <- c(1.5, 2.8, pi)

character <- c("this", "is", "a character", "vector")
```

Augmented
---------

Augmented vectors are atomic vectors with additional metadata. There are four important augmented vectors:

-   **factors** `<fct>`, which are used to represent categorical variables can take one of a fixed and known set of possible values (called the levels).

-   **ordered factors** `<ord>`, which are like factors but where the levels have an intrinsic ordering (i.e. it's reasonable to say that one level is "less than" or "greater than" another variable).

-   **dates** `<dt>`, record a date.

-   **date-times** `<dttm>`, which are also known as POSIXct, record a date and a time.

For now, you just need to recognise these when you encounter them. You'll learn how to create each type of augmented vector later in the course.

Data frames/tibbles
-------------------

Related vectors (both atomic and augment) are collected together into data frames or tibbles. Later you'll learn the precise different between data.frames and tibbles, but don't worry about it for now. There are two ways to create tibbles by hand:

1.  From individual vectors, each representing a column:

    ``` r
    my_tibble <- tibble(
      x = c(1, 9, 5),
      y = c(TRUE, FALSE, FALSE),
      z = c("apple", "pear", "banana")
    )
    my_tibble
    #> # A tibble: 3 × 3
    #>       x     y      z
    #>   <dbl> <lgl>  <chr>
    #> 1     1  TRUE  apple
    #> 2     9 FALSE   pear
    #> 3     5 FALSE banana
    ```

2.  From individual values, organised in rows:

    ``` r
    my_tibble <- tribble(
      ~x, ~y,    ~z,
      1,  TRUE,  "apple",
      9,  FALSE, "pear",
      5,  FALSE, "banana"
    )
    my_tibble
    #> # A tibble: 3 × 3
    #>       x     y      z
    #>   <dbl> <lgl>  <chr>
    #> 1     1  TRUE  apple
    #> 2     9 FALSE   pear
    #> 3     5 FALSE banana
    ```

Typically it will be obvious whether you need to use `tibble()` or `tribble()`. One representation will either be much shorter or much clearer than the other.

### Dimensions

When you print a tibble it tell you its column names and the overall dimensions:

``` r
diamonds
#> # A tibble: 53,940 × 10
#>    carat       cut color clarity depth table price     x     y     z
#>    <dbl>     <ord> <ord>   <ord> <dbl> <dbl> <int> <dbl> <dbl> <dbl>
#> 1   0.23     Ideal     E     SI2  61.5    55   326  3.95  3.98  2.43
#> 2   0.21   Premium     E     SI1  59.8    61   326  3.89  3.84  2.31
#> 3   0.23      Good     E     VS1  56.9    65   327  4.05  4.07  2.31
#> 4   0.29   Premium     I     VS2  62.4    58   334  4.20  4.23  2.63
#> 5   0.31      Good     J     SI2  63.3    58   335  4.34  4.35  2.75
#> 6   0.24 Very Good     J    VVS2  62.8    57   336  3.94  3.96  2.48
#> 7   0.24 Very Good     I    VVS1  62.3    57   336  3.95  3.98  2.47
#> 8   0.26 Very Good     H     SI1  61.9    55   337  4.07  4.11  2.53
#> 9   0.22      Fair     E     VS2  65.1    61   337  3.87  3.78  2.49
#> 10  0.23 Very Good     H     VS1  59.4    61   338  4.00  4.05  2.39
#> # ... with 53,930 more rows
```

If you want to get access dimensions directly, you have three options:

``` r
dim(diamonds)
#> [1] 53940    10
nrow(diamonds)
#> [1] 53940
ncol(diamonds)
#> [1] 10
```

To get the variable names, use `names()`:

``` r
names(diamonds)
#>  [1] "carat"   "cut"     "color"   "clarity" "depth"   "table"   "price"  
#>  [8] "x"       "y"       "z"
```

There isn't currently a convenient way to get the variable types, but you can use `purrr::map_chr()` to apply `type_sum()` (short for type summary) to each variable.

``` r
type_sum(diamonds)
#> [1] "tibble"
map_chr(diamonds, type_sum)
#>   carat     cut   color clarity   depth   table   price       x       y 
#>   "dbl"   "ord"   "ord"   "ord"   "dbl"   "dbl"   "int"   "dbl"   "dbl" 
#>       z 
#>   "dbl"
```

