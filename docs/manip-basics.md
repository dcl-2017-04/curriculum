# Data science basics

Some basic data manipulation is essential for many visualisations. Here you'll
the learn the most important dplyr functions: `filter()`, `mutate()`, and
`group_by()` + `summarise()`.

## Readings

  * [Filter rows with filter()](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) [r4ds-5.2]

  * [Add new variables with mutate()](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate) [r4ds-5.5]

  * [Grouped summaries with summarise()](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) [r4ds-5.6]


## Exercises
[manip-basics-exercises.Rmd](manip-basics-exercises.Rmd)


1.  Find all flights that:

    1.  Had an depature delay of two or more hours
    2.  Arrived more than two hours late, but didn’t leave late
    3.  Flew to Houston (IAH or HOU)

2.  Compute the departure delay yourself by computing the difference between `dep_time` and `sched_dep_time`. (Hint: convert to "decimal" time = `hour + minutes / 60`).

3.  Which destination has the highest average delay? Which destination that had over 100 flights has highest average delay?

