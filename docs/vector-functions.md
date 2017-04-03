---
title: Vector functions
---

<!-- Generated automatically from vector-functions.yml. Do not edit by hand -->

# Vector functions <small class='program'>[program]</small>
<small>(Builds on: [Exploratory data analysis](eda.md), [Atomic vectors](vectors.md))</small>  
<small>(Leads to: [Iteration](iteration.md))</small>

Functions are powerful tool for reducing the amount of duplication in your
code. Reducing duplicationg is a good principle because it means that
each "fact" in your code is only stored in one place. When the requirements
of your code change (as they invariably do), you only need to make the
change in a single place, reducing the chances of inconsistencies within
your code.

To start with, we'll focus on functions that work with vectors. There
are two common types:

* Vectorised functions that return an output the same length as their
  input. You typically use these functions in `mutate()`.

* Summary functions that return an output of length one. You typically
  use these functions with `summarise()`.

## Readings

  * [Introduction](http://r4ds.had.co.nz/functions.html#introduction-12) [r4ds-19.1]

  * [When should you write a function?](http://r4ds.had.co.nz/functions.html#when-should-you-write-a-function) [r4ds-19.2]

  * [Functions are for humans and computers](http://r4ds.had.co.nz/functions.html#functions-are-for-humans-and-computers) [r4ds-19.3]



