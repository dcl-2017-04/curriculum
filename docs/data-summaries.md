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


## Exercises

1.  Create a helper function to compute the coefficient of variation of a vector.
    Create a helper function to compute the proportion of missing values in
    a vector.
    
1.  To understand how airline delays vary daily over the course of a year, you
    need to summarise each day with a single number. Which variable should you
    use? Compare summaries using `mean()`, `median()`, and mean(x > cutoff)`.
    How do they differ? Which do you think is best?
    
1.  Perhaps it's not actually the average delay that's most important, but
    the variability in the delays. What's a good summary?
    
1.  Using the summary that you think is most appropriate, explore the average
    delay by destination. Explore the distribution of your summary. Can you
    explain the location with the 5 highest and 5 lowest values?
    
1.  Sometimes the number or proportion of missing values can be extremely
    informative. Compute the proportion of flights missing departure times
    for each day. Visualise the results. What do missing values represent?
    How do they vary over the course of the year? How are they related to
    delays?
    

## Supplemental readings

  * [Coefficient of variation [wikipedia]](https://en.wikipedia.org/wiki/Coefficient_of_variation)

  * [Data Visualization Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf) [cheatsheets-ggplot2-2.1].
    Use the ggplot2 cheatsheet to jog your memory of what's available.

  * [A Tale of Twenty-Two Million Citi Bike Rides: Analyzing the NYC Bike Share System](http://toddwschneider.com/posts/a-tale-of-twenty-two-million-citi-bikes-analyzing-the-nyc-bike-share-system/).
    This analysis by Todd W. Schneider uses R (along with other tools) to
    analyse over 20 million bike rides in NYC. As you read through the analysis
    think how you would do it yourself using the techniques you have learned so
    far.

  * [Analyzing 1.1 Billion NYC Taxi and Uber Trips, with a Vengeance](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/).
    This analysis, also by Todd W. Schneider, uses much more data than the
    previous analysis. What additional challenges did Todd need to solve to
    allow him to work with this much data?



