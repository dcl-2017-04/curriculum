---
title: Google sheets
---

<!-- Generated automatically from googlesheets.yml. Do not edit by hand -->

# Google sheets <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Parsing basics](parse-basics.md))</small>


Use googlesheets by Jenny Bryan to (suprise!) extract data from googlesheets. Sheets is a surprisingly useful way of collaboratively collecting data (especially with google forms); googlesheets makes it easy to get that data into R and make use of it.

If you haven't already, install it:

``` r
install.packages("googlesheets")
```

``` r
library(googlesheets)
```

Sheet sources
-------------

Two basic sources of sheets:

1.  Your sheets
2.  Public sheets

### Public sheets

<https://docs.google.com/spreadsheets/d/1twq7WtX5mor07gR8hjZ0bErOEP8iZJFxD6Q3PUSQ-Z8/pubhtml>

``` r
gs_url("https://docs.google.com/spreadsheets/d/1twq7WtX5mor07gR8hjZ0bErOEP8iZJFxD6Q3PUSQ-Z8/pubhtml")
gs_read()
```

### Your sheets

Key challenge is identifying the sheet you want:

``` r
gs_ls()
gs_ls("Gapminder")
```

This will create a file called `.httr-oauth` in your current directory. NEVER CHECK THIS INTO GIT. (In the RStudio git pane, right-click on it and select ignore, then press OK.)

``` r
gs_key()
```
