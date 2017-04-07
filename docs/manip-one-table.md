---
title: Other single table verbs
---

<!-- Generated automatically from manip-one-table.yml. Do not edit by hand -->

# Other single table verbs <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Manipulation basics](manip-basics.md))</small>


You've learned the most important verbs for data analysis: `filter()`, `mutate()`, `group_by()` and `summarise()`. There are a nubmer of other verbs that are not quite as important but still come in handy from time-to-time. The goal of this document is to familiarise you with their purpose and basic operation

``` r
library(tidyverse)
library(nycflights13)
```

Select
------

Most of the datasets you'll work with in this class only have a relatively small number of variables, and generally you don't need to reduce further. In real life, you'll sometimes encounter datasets with hundreds or even thousands of variables, and the first challenge is just to narrow down to a useful subset. Solving that problem is the job of `select()`.

`select()` allows you to work with column names using a handful of helper functions:

-   `starts_with("x")` and `ends_with("x")` select variables that start with a common prefix or end with a common suffix.

-   `contains("x")` selects variables that contain a phrase. `matches("x.y")` select all variables that match a given regular expression (which you'll learn about later in the course).

-   `a:e` selects all variables from variable `a` to variable `e` inclsive.

You can also select a single varible just by using its name directly.

``` r
flights %>% select(year:day, ends_with("delay"))
#> # A tibble: 336,776 × 5
#>     year month   day dep_delay arr_delay
#>    <int> <int> <int>     <dbl>     <dbl>
#> 1   2013     1     1         2        11
#> 2   2013     1     1         4        20
#> 3   2013     1     1         2        33
#> 4   2013     1     1        -1       -18
#> 5   2013     1     1        -6       -25
#> 6   2013     1     1        -4        12
#> 7   2013     1     1        -5        19
#> 8   2013     1     1        -3       -14
#> 9   2013     1     1        -3        -8
#> 10  2013     1     1        -2         8
#> # ... with 336,766 more rows
```

To remove variables from selection, put a `-` in front of the expression.

``` r
flights %>% select(-starts_with("dep"))
#> # A tibble: 336,776 × 17
#>     year month   day sched_dep_time arr_time sched_arr_time arr_delay
#>    <int> <int> <int>          <int>    <int>          <int>     <dbl>
#> 1   2013     1     1            515      830            819        11
#> 2   2013     1     1            529      850            830        20
#> 3   2013     1     1            540      923            850        33
#> 4   2013     1     1            545     1004           1022       -18
#> 5   2013     1     1            600      812            837       -25
#> 6   2013     1     1            558      740            728        12
#> 7   2013     1     1            600      913            854        19
#> 8   2013     1     1            600      709            723       -14
#> 9   2013     1     1            600      838            846        -8
#> 10  2013     1     1            600      753            745         8
#> # ... with 336,766 more rows, and 10 more variables: carrier <chr>,
#> #   flight <int>, tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>,
#> #   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>
```

There's one last helper that's useful if you just want to move a few variables to the start: `everything()`.

``` r
flights %>% select(dep_delay, arr_delay, everything())
#> # A tibble: 336,776 × 19
#>    dep_delay arr_delay  year month   day dep_time sched_dep_time arr_time
#>        <dbl>     <dbl> <int> <int> <int>    <int>          <int>    <int>
#> 1          2        11  2013     1     1      517            515      830
#> 2          4        20  2013     1     1      533            529      850
#> 3          2        33  2013     1     1      542            540      923
#> 4         -1       -18  2013     1     1      544            545     1004
#> 5         -6       -25  2013     1     1      554            600      812
#> 6         -4        12  2013     1     1      554            558      740
#> 7         -5        19  2013     1     1      555            600      913
#> 8         -3       -14  2013     1     1      557            600      709
#> 9         -3        -8  2013     1     1      557            600      838
#> 10        -2         8  2013     1     1      558            600      753
#> # ... with 336,766 more rows, and 11 more variables: sched_arr_time <int>,
#> #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
#> #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
#> #   time_hour <dttm>
```

Rename
------

To change the name of a variable use `df %>% rename(new_name = old_name)`. If you have trouble remembering which sides old and new go on, remember it's the same order as `mutate()`.

``` r
flights %>% rename(tail_num = tailnum)
#> # A tibble: 336,776 × 19
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     1     1      517            515         2      830
#> 2   2013     1     1      533            529         4      850
#> 3   2013     1     1      542            540         2      923
#> 4   2013     1     1      544            545        -1     1004
#> 5   2013     1     1      554            600        -6      812
#> 6   2013     1     1      554            558        -4      740
#> 7   2013     1     1      555            600        -5      913
#> 8   2013     1     1      557            600        -3      709
#> 9   2013     1     1      557            600        -3      838
#> 10  2013     1     1      558            600        -2      753
#> # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tail_num <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>
```

Transmute
---------

Transmute is a minor variation of `mutate()`. The main difference is that it drops any variables that you didn't explicitly mention. It's a useful shortcut for `mutate()` + `select()`.

``` r
df <- tibble(x = 1:3, y = 3:1)

# mutate() keeps all the variables
df %>% mutate(z = x + y)
#> # A tibble: 3 × 3
#>       x     y     z
#>   <int> <int> <int>
#> 1     1     3     4
#> 2     2     2     4
#> 3     3     1     4

# transmute() drops all the variables
df %>% transmute(z = x + y)
#> # A tibble: 3 × 1
#>       z
#>   <int>
#> 1     4
#> 2     4
#> 3     4
```

Arrange
-------

`arrange()` lets you change the order of the rows. To put a column in descending order, use `desc()`.

``` r
flights %>% arrange(desc(dep_delay))
#> # A tibble: 336,776 × 19
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     1     9      641            900      1301     1242
#> 2   2013     6    15     1432           1935      1137     1607
#> 3   2013     1    10     1121           1635      1126     1239
#> 4   2013     9    20     1139           1845      1014     1457
#> 5   2013     7    22      845           1600      1005     1044
#> 6   2013     4    10     1100           1900       960     1342
#> 7   2013     3    17     2321            810       911      135
#> 8   2013     6    27      959           1900       899     1236
#> 9   2013     7    22     2257            759       898      121
#> 10  2013    12     5      756           1700       896     1058
#> # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>
flights %>% arrange(year, month, day)
#> # A tibble: 336,776 × 19
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     1     1      517            515         2      830
#> 2   2013     1     1      533            529         4      850
#> 3   2013     1     1      542            540         2      923
#> 4   2013     1     1      544            545        -1     1004
#> 5   2013     1     1      554            600        -6      812
#> 6   2013     1     1      554            558        -4      740
#> 7   2013     1     1      555            600        -5      913
#> 8   2013     1     1      557            600        -3      709
#> 9   2013     1     1      557            600        -3      838
#> 10  2013     1     1      558            600        -2      753
#> # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>
```

Distinct
--------

`distinct()` removes duplicates from a dataset. The result is ordered by first occurence in original dataset.

``` r
flights %>% distinct(carrier, flight)
#> # A tibble: 5,725 × 2
#>    carrier flight
#>      <chr>  <int>
#> 1       UA   1545
#> 2       UA   1714
#> 3       AA   1141
#> 4       B6    725
#> 5       DL    461
#> 6       UA   1696
#> 7       B6    507
#> 8       EV   5708
#> 9       B6     79
#> 10      AA    301
#> # ... with 5,715 more rows
```

Sample
------

When working with very large datasets, sometimes it's convenient to reduce to a smaller dataset, just by taking a random sample. That's the job of `sample_n()` and `sample_frac()`. `sample_n()` selects the same number of observations from each group, `sample_frac()` selects the same proportion.

``` r
popular_dest <- flights %>%
  group_by(dest) %>%
  filter(n() > 1000)

# Creates a dataset with the same number of flights to each dest
popular_dest %>% sample_n(100)
#> Source: local data frame [5,800 x 19]
#> Groups: dest [58]
#> 
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     8     7      811            810         1     1124
#> 2   2013     5     9     1639           1600        39     1845
#> 3   2013     8    19     1201           1205        -4     1423
#> 4   2013    10     2     1641           1645        -4     1901
#> 5   2013     6    26     1451           1325        86     1731
#> 6   2013     6    17     2108           2000        68     2336
#> 7   2013    11     6      630            630         0      919
#> 8   2013     3     8     1458           1200       178     1711
#> 9   2013     3    22     1631           1630         1     1851
#> 10  2013    10    25      855            900        -5     1111
#> # ... with 5,790 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>

# Creates a dataset with proportion number of flights to each dest
popular_dest %>% sample_frac(0.01)
#> Source: local data frame [3,205 x 19]
#> Groups: dest [58]
#> 
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     7    16     1544           1459        45     1823
#> 2   2013    11    26     1306           1300         6     1543
#> 3   2013     6     7     1214           1205         9     1436
#> 4   2013     1    21      810            810         0     1033
#> 5   2013     7    27     1627           1620         7     1856
#> 6   2013     7     9     1758           1330       268     2046
#> 7   2013     6     2     1603           1600         3     1836
#> 8   2013     2     2     1952           2000        -8     2158
#> 9   2013     7    25     1304           1310        -6     1515
#> 10  2013     6     6     1522           1520         2     1809
#> # ... with 3,195 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>
```

Slice rows
----------

`slice()` allows to pick rows by position, by group. `head()` and `tail()` just show the first (or last) few rows of the entire data frame.

``` r
# first flights to each dest
flights %>% group_by(dest) %>% slice(1:5)
#> Source: local data frame [517 x 19]
#> Groups: dest [105]
#> 
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013    10     1     1955           2001        -6     2213
#> 2   2013    10     2     2010           2001         9     2230
#> 3   2013    10     3     1955           2001        -6     2232
#> 4   2013    10     4     2017           2001        16     2304
#> 5   2013    10     5     1959           1959         0     2226
#> 6   2013    10     1     1149           1159       -10     1245
#> 7   2013    10     2     1152           1159        -7     1259
#> 8   2013    10     3     1211           1159        12     1316
#> 9   2013    10     4      757            800        -3      859
#> 10  2013    10     4     1154           1159        -5     1258
#> # ... with 507 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>

# first flights overall
flights %>% head()
#> # A tibble: 6 × 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     1     1      517            515         2      830
#> 2  2013     1     1      533            529         4      850
#> 3  2013     1     1      542            540         2      923
#> 4  2013     1     1      544            545        -1     1004
#> 5  2013     1     1      554            600        -6      812
#> 6  2013     1     1      554            558        -4      740
#> # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
#> #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
#> #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
#> #   time_hour <dttm>

# last flights overall
flights %>% tail()
#> # A tibble: 6 × 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     9    30       NA           1842        NA       NA
#> 2  2013     9    30       NA           1455        NA       NA
#> 3  2013     9    30       NA           2200        NA       NA
#> 4  2013     9    30       NA           1210        NA       NA
#> 5  2013     9    30       NA           1159        NA       NA
#> 6  2013     9    30       NA            840        NA       NA
#> # ... with 12 more variables: sched_arr_time <int>, arr_delay <dbl>,
#> #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
#> #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
#> #   time_hour <dttm>
```

