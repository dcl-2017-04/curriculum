---
title: Data structure basics
---

<!-- Generated automatically from data-structure-basics.yml. Do not edit by hand -->

# Data structure basics <small class='program'>[program]</small>
<small>(Builds on: [Setup](setup.md))</small>


It's helpful to know a little bit about how data structures are organised in R. The simplest data structure in R is the vector, which can be broken up in to atomic vectors and augmented vectors. Vectors of related data are organised together in tibbles and data.frames.

``` r
library(tidyverse)
```

Atomic vectors
--------------

The atomic vectors are the "atoms" of R, the simple building blocks upon which all else is built. There are four types of atomic vector that are important for data analysis:

-   **logical** vectors (lgl) contain `TRUE` or `FALSE`.
-   **integer** vectors (int) contain integers.
-   **double** vectors (dbl) contain real numbers.
-   **character** vector (chr) contain strings made with `""`.

All vectors can also contain the missing value `NA`. You'll learn more about missing values later on. Collectively integer and double vectors are known as **numeric** vectors. The difference is rarely important in R.

You create atomic vectors by hand with the `c()` function:

``` r
logical <- c(TRUE, FALSE, FALSE)

# The difference between the real number 1 and the integer 1 is not 
# usually important, but soemtimes it comes up in base R code. R uses
# the suffix "L" to indicate that a number is an integer.
integer <- c(1L, 2L, 3L)

double <- c(1.5, 2.8, pi)

character <- c("this", "is", "a character", "vector")
```

Augmented
---------

Augmented vectors are atomic vectors with additional metadata. There are four important augmented vectors:

-   factors (fct), which are used to represent categorical variables can take one of a fixed and known set of possible values (called the levels).

-   ordered factors (ord), which are like factors but where the level have an intrinsic ordering (i.e. it's reasonable to say that one level is "less than" or "greater than" another variable).

-   dates (dt), which represe

-   date/times also known as POSIXct (dttm)

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
    ```

        ## # A tibble: 3 × 3
        ##       x     y      z
        ##   <dbl> <lgl>  <chr>
        ## 1     1  TRUE  apple
        ## 2     9 FALSE   pear
        ## 3     5 FALSE banana

2.  From individual values, organised in rows:

    ``` r
    my_tibble <- tribble(
      ~x, ~y,    ~z,
      1,  TRUE,  "apple",
      9,  FALSE, "pear",
      5,  FALSE, "banana"
    )
    my_tibble
    ```

        ## # A tibble: 3 × 3
        ##       x     y      z
        ##   <dbl> <lgl>  <chr>
        ## 1     1  TRUE  apple
        ## 2     9 FALSE   pear
        ## 3     5 FALSE banana

Typically it will be obvious whether you need to use `tibble()` or `tribble()`. One representation will either be much shorter or much clearer than the other.

