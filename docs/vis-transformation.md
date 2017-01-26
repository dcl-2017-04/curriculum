---
title: Visual transformations
---

<!-- Generated automatically from vis-transformation.yml. Do not edit by hand -->

# Visual transformations

<small>(Builds on [The grammar of graphics](vis-theory.md))</small>


You've already learned about transformation functions that you use with `dplyr::mutate()`. They take one (or more) vectors and return a transformed vector of the same length. The ggplot2 equivalent of transformation functions are the scales. They take variables (numeric, character, ...) and convert them to visual properties (colour, shape, ...).
Scales also control the axes and legends which help the reader understand the plot. Mastering this aspect of scales is important when creating plots for others to understand. We'll come back to this idea later.

## Readings

  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6].
    You can skip §6.3 and §6.4: we'll discuss them in detail when we talk more
    about plots for communication.



