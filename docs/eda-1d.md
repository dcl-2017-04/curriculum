---
title: Exploratory data analysis (1D)
---

<!-- Generated automatically from eda-1d.yml. Do not edit by hand -->

# Exploratory data analysis (1D) <small class='explore'>[explore]</small>
<small>(Builds on: [Visualisation basics (1)](vis-basics.md), [Manipulation basics](manip-basics.md))</small>  
<small>(Leads to: [Exploratory data analysis (2D)](eda-2d.md), [Parsing vectors](parse-vector.md), [Essentials of relational data](relational-basics.md), [String basics](string-basics.md), [Tidy data](tidy-data.md), [Vector functions](vector-functions.md))</small>


Exploratory data analysis is partly a set of techniques, but is mostly a mindset: you want to remain open to what the data is telling you.

``` r
library(tidyverse)
library(nycflights13)
```

Whenever you start working with a new variable, it's a really good idea to first take a look at the variable by itself, before you start combining it with other variables. As well as the visual techniques you'll learn in the readings, another quick and dirty function is `count()`.

`df %>% count(grp)` is shorthand for `df %>% group_by(grp) %>% summarise(n = n())`.

``` r
flights %>% count(carrier)
```

    ## # A tibble: 16 × 2
    ##    carrier     n
    ##      <chr> <int>
    ## 1       9E 18460
    ## 2       AA 32729
    ## 3       AS   714
    ## 4       B6 54635
    ## 5       DL 48110
    ## 6       EV 54173
    ## 7       F9   685
    ## 8       FL  3260
    ## 9       HA   342
    ## 10      MQ 26397
    ## 11      OO    32
    ## 12      UA 58665
    ## 13      US 20536
    ## 14      VX  5162
    ## 15      WN 12275
    ## 16      YV   601

It has two convenient arguments:

-   `sort = TRUE` automatically arranges the result so the most common values are at the top

    ``` r
    flights %>% count(dest, sort = TRUE)
    ```

        ## # A tibble: 105 × 2
        ##     dest     n
        ##    <chr> <int>
        ## 1    ORD 17283
        ## 2    ATL 17215
        ## 3    LAX 16174
        ## 4    BOS 15508
        ## 5    MCO 14082
        ## 6    CLT 14064
        ## 7    SFO 13331
        ## 8    FLL 12055
        ## 9    MIA 11728
        ## 10   DCA  9705
        ## # ... with 95 more rows

-   `wt = my_variable` switches from a count to a weight sum of `my_variable`. For example, the following code gives the total amount distance traveled by each carrier. It is particularly useful if you have data that has already been aggregated.

    ``` r
    flights %>% count(carrier, wt = distance)
    ```

        ## # A tibble: 16 × 2
        ##    carrier        n
        ##      <chr>    <dbl>
        ## 1       9E  9788152
        ## 2       AA 43864584
        ## 3       AS  1715028
        ## 4       B6 58384137
        ## 5       DL 59507317
        ## 6       EV 30498951
        ## 7       F9  1109700
        ## 8       FL  2167344
        ## 9       HA  1704186
        ## 10      MQ 15033955
        ## 11      OO    16026
        ## 12      UA 89705524
        ## 13      US 11365778
        ## 14      VX 12902327
        ## 15      WN 12229203
        ## 16      YV   225395

You can also `count()` the value of expression. This is a useful technique to get a quick count of how many missing values there are:

``` r
flights %>% count(is.na(dep_delay))
```

    ## # A tibble: 2 × 2
    ##   `is.na(dep_delay)`      n
    ##                <lgl>  <int>
    ## 1              FALSE 328521
    ## 2               TRUE   8255

``` r
flights %>% count(
  dep_missing = is.na(dep_time), 
  arr_missing = is.na(arr_time)
)
```

    ## # A tibble: 3 × 3
    ##   dep_missing arr_missing      n
    ##         <lgl>       <lgl>  <int>
    ## 1       FALSE       FALSE 328063
    ## 2       FALSE        TRUE    458
    ## 3        TRUE        TRUE   8255

You can combine `count()` with the `cut_*` functions from ggplot2 to compute histograms "by hand":

``` r
# five bins of equal widths
flights %>% count(cut_interval(arr_delay, 5))
```

    ## # A tibble: 6 × 2
    ##   `cut_interval(arr_delay, 5)`      n
    ##                         <fctr>  <int>
    ## 1                    [-86,186] 323807
    ## 2                    (186,457]   3465
    ## 3                    (457,729]     45
    ## 4                  (729,1e+03]     25
    ## 5             (1e+03,1.27e+03]      4
    ## 6                           NA   9430

``` r
# five bins with approximately equal numbers of points
flights %>% count(cut_number(arr_delay, 5))
```

    ## # A tibble: 6 × 2
    ##   `cut_number(arr_delay, 5)`     n
    ##                       <fctr> <int>
    ## 1                  [-86,-19] 70875
    ## 2                  (-19,-10] 61570
    ## 3                    (-10,1] 66972
    ## 4                     (1,21] 62970
    ## 5              (21,1.27e+03] 64959
    ## 6                         NA  9430

``` r
# hourly bins
flights %>% count(cut_width(arr_delay, 60, boundary = 0))
```

    ## # A tibble: 22 × 2
    ##    `cut_width(arr_delay, 60, boundary = 0)`      n
    ##                                      <fctr>  <int>
    ## 1                                [-120,-60]    240
    ## 2                                   (-60,0] 194102
    ## 3                                    (0,60] 105215
    ## 4                                  (60,120]  17755
    ## 5                                 (120,180]   6191
    ## 6                                 (180,240]   2291
    ## 7                                 (240,300]    941
    ## 8                                 (300,360]    365
    ## 9                                 (360,420]    144
    ## 10                                (420,480]     37
    ## # ... with 12 more rows

## Readings

  * [Introduction](http://r4ds.had.co.nz/exploratory-data-analysis.html#introduction-3) [r4ds-7.1]

  * [Questions](http://r4ds.had.co.nz/exploratory-data-analysis.html#questions) [r4ds-7.2]

  * [Variation](http://r4ds.had.co.nz/exploratory-data-analysis.html#variation) [r4ds-7.3]


