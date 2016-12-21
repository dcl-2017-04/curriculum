# Data summaries

Summary functions take a vector of data and return a single number. You Summary
geoms divide the data into pieces, apply some summary and visualise the
results. Summaries are useful when you have a lot of data (and plotting leads
to overplotting), or when the data is noisy (and you need to make small but
consistent patterns more clear). Here we apply these tools to small (in-memory)
data, but they're still useful when you have big (out-of-memory) data. That's
because a powerful strategy for working with big data is to make it small with
some combination of subsetting, summarising, or sampling.

## Readings

  * [Useful summary functions](http://r4ds.had.co.nz/transform.html#summarise-funs) [r4ds-5.6.4].
    Familiarise yourself with the summary functions that you can use in
    conjunction with `summarise()`

  * [Toolbox](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_3) [ggplot2-3].
    Familiarise yourself with the geoms that you can use to summarise data
    visually.

  * [Introduction](http://r4ds.had.co.nz/functions.html#introduction-12) [r4ds-19.1].
    Not every summary function you need already exists. Sometimes you'll need
    to combine one or more existing summaries to compute what you want. While
    you can do this inline, it will make your code easier to use if you use
    small helper functions.

  * [When should you write a function?](http://r4ds.had.co.nz/functions.html#when-should-you-write-a-function) [r4ds-19.2]

  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling].
    The cheatsheet includes a list of the most important summary functions.
    Refer to it when you forget.



