---
title: Spreading and gathering
---

<!-- Generated automatically from spread-gather.yml. Do not edit by hand -->

# Spreading and gathering <small class='wrangle'>[wrangle]</small>
<small>(Builds on: [Tidy data](tidy-data.md))</small>

The two most common ways for data to be messy are to have:

1. One variable spread across multiple columns.
1. One observation scattered across multiple rows.

To fix these problems you need `spread()` and `gather()` from the
tidyr package.

`spread()` and `gather()` also illustrate a new type of missingness.
So far we've discussed explicit missing values (`NA`), but it's also
possible for missing values to be simply absent from the data.

## Readings

  * [Spreading and gathering](http://r4ds.had.co.nz/tidy-data.html#spreading-and-gathering) [r4ds-12.3]

  * [Missing values](http://r4ds.had.co.nz/tidy-data.html#missing-values-3) [r4ds-12.5].
    (explicit vs implicit). We haven't covered the vocabulary of "tidy data"
    yet, but be aware that different ways of organisation the same data may
    make explicit missing values that were previously implicit in the data.


