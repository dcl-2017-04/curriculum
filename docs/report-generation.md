---
title: Generating multiple reports
---

<!-- Generated automatically from report-generation.yml. Do not edit by hand -->

# Generating multiple reports <small class='communicate'>[communicate]</small>
<small>(Builds on: [List columns](list-cols.md), [R Markdown basics](rmarkdown-basics.md))</small>

So far you've turned `.Rmd` files into fully-fleshed reports using
RStudio. It is also useful to know how to do so programmatically so that
you can automate your R Markdown workflow. This is particularly useful
in conjunction with parameterised reports and `purrr::pwalk()`.

This technique isn't discussed frequently, but I think it's extremely
powerful. It might stretch your brain a bit, and you might not understand
exactly how it works, but it's useful pattern to know.

## Readings

  * [http://rmarkdown.rstudio.com/developer_parameterized_reports.html](http://rmarkdown.rstudio.com/developer_parameterized_reports.html).
    Focus particularly on the "passing parameters" section as that shows how to
    call `rmarkdown::render()`, which is the code equivalent of the "knit"
    button in RStudio.

  * [Mapping over multiple arguments](http://r4ds.had.co.nz/iteration.html#mapping-over-multiple-arguments) [r4ds-21.7]

  * [Walk](http://r4ds.had.co.nz/iteration.html#walk) [r4ds-21.8].
    The purrr function we're going to use is `pwalk()`. It isn't described in
    detail in R4DS but it's a combination of `pmap()` and `walk()`.

  * [YAML header](http://r4ds.had.co.nz/r-markdown.html#yaml-header) [r4ds-27.6].
    Read only §27.6.1; you can skip §27.6.2 for now.


