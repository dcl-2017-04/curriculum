---
title: Summarise and mutate helpers
---

<!-- Generated automatically from manip-helpers.yml. Do not edit by hand -->

# Summarise and mutate helpers
<small>(Builds on: [Data manipulation basics](manip-basics.md))</small>

Grouped summaries and mutates are such a commonly used technique that dplyr
comes with a number of helpers to save you some typing:

* `count()` simplifies the process of counting the number of cases in
  each group. `df %>% count(df, x)` is shorthand for
  `df %>% group_by(x) %>% summarise(n = n())`. It can also perform weighted
  sums if you provide the `wt` argument.

* `transmute()` works like `mutate()`, but doesn't carry across
  existing variables.

* `summarise_if()`, `summarise_at()`, `summarise_all()` make it
  easier to summarise multiple columns at once. `summarise_if()` allows
  you to summarise all variables for which a predicate returns true;
  `summarise_at()` allows you to summarise specific variables with a
  `select()`-style specification; `summarise_all()` summarises all variables.

* `mutate_if()`, `mutate_at()`, and `mutate_all()` work similarly for
  adding new variables

These are not described in detail in R4DS, so you'll need to read the
documentation. I recomend starting with the examples, copying them
into a new window, then running line-by-line.

## Readings

The documentation



