<!-- Generated automatically from syllabus.yml. Do not edit by hand -->
# Exploratory data analysis (Week 2)

Good data analysis involves fluid transitions between transformation and
visualisation. This week you'll practice those tools by using them for EDA
(exploratory data analysis), and diving into some of the details of dplyr and
ggplot2 that we elided last week.

## EDA
(estimated duration: 30 mins)

Exploratory data analysis is partly a set of techniques, but is mostly a
mindset: you want to remain open to what the data is telling you. You'll learn
the techniques in the readings, and then practice the mindset in class and in
the challenges.

### Readings

  * [Introduction](http://r4ds.had.co.nz/exploratory-data-analysis.html#introduction-3) [r4ds-7.1]
  * [Questions](http://r4ds.had.co.nz/exploratory-data-analysis.html#questions) [r4ds-7.2]
  * [Variation](http://r4ds.had.co.nz/exploratory-data-analysis.html#variation) [r4ds-7.3]
  * [Covariation](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation) [r4ds-7.5]

### Exercises

1.  Explore the distribution of `diamonds$price`. Do you discover anything
    unusual or surprising? (Hint: Carefully think about the binwidth and make
    sure you try a wide range of values.) Describe your findings and brainstorm
    possible explanations.

## ggplot2 theory

Now that you have some experience with ggplot2, we'll fill in the blanks with a
more systematic exploration of the details. Read Chapters 4 and 5 to get a
better handle on the underyling theory (the Grammar of Graphics).

### Readings

  * [Mastering the grammar](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_4) [ggplot2-4]
  * [Build a plot layer by layer](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_5) [ggplot2-5]
  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6]
  * [Data Visualization Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf) [cheatsheets-ggplot2-2.1]


## Data summaries

Summary functions take a vector of data and return a single number. You Summary
geoms divide the data into pieces, apply some summary and visualise the
results. Summaries are useful when you have a lot of data (and plotting leads
to overplotting), or when the data is noisy (and you need to make small but
consistent patterns more clear). Here we apply these tools to small (in-memory)
data, but they're still useful when you have big (out-of-memory) data. That's
because a powerful strategy for working with big data is to make it small with
some combination of subsetting, summarising, or sampling.

### Readings

  * [Useful summary functions](http://r4ds.had.co.nz/transform.html#summarise-funs) [r4ds-5.6.4]
  * [Introduction](http://r4ds.had.co.nz/functions.html#introduction-12) [r4ds-19.1]

    Not every summary function you need already exists. Sometimes you'll need
    to combine one or more existing summaries to compute what you want. While
    you can do this inline, it will make your code easier to use if you use
    small helper functions.

  * [When should you write a function?](http://r4ds.had.co.nz/functions.html#when-should-you-write-a-function) [r4ds-19.2]
  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling]

    The cheatsheet includes a list of the most important summary functions.
    Refer to it when you forget.


### Exercises

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
    
### Supplemental readings

  * [Coefficient of variation [wikipedia]](https://en.wikipedia.org/wiki/Coefficient_of_variation)
  * [A Tale of Twenty-Two Million Citi Bike Rides: Analyzing the NYC Bike Share System](http://toddwschneider.com/posts/a-tale-of-twenty-two-million-citi-bikes-analyzing-the-nyc-bike-share-system/)

    This analysis by Todd W. Schneider uses R (along with other tools) to
    analyse over 20 million bike rides in NYC. As you read through the analysis
    think how you would do it yourself using the techniques you have learned so
    far.

  * [Analyzing 1.1 Billion NYC Taxi and Uber Trips, with a Vengeance](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/)

    This analysis, also by Todd W. Schneider, uses much more data than the
    previous analysis. What additional challenges did Todd need to solve to
    allow him to work with this much data?



## Data transformations

Transformation functions take one (or more) vectors and return a transformed
vector of the same length. They are often needed using your domain knowledge to
re-paramerising the data can make patterns more clear. Transformation are
important in visualisations, as sometimes you'll want to do a quick and dirty
transformation in the call to `aes()`. However, another important
transformation always occurs during visualisation: transformation from data to
visual properties. This is handled by the scales.

### Readings

  * [Useful creation functions](http://r4ds.had.co.nz/transform.html#mutate-funs) [r4ds-5.5.1]

    Make sure that you're familiar with the most important existing
    transformations.

  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6]
  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling]

    The cheatsheet includes a list of the most important transformation
    functions. Refer to it when you forget.


### Exercises

1.  Whenever your data includes a variable that could be calculated from other
    variables in your dataset, you should always recalculate it and compare.
    In the diamonds dataset, you could approximate `depth` from `x`, `y`, `z`
    
1.  You could also approximate `carat` using `x`, `y`, and `z`. Start your
    approximation by assuming that diamonds are cubes and computing the volume.
    How are the volume and weight related? Can you use a better geometric
    approximation? Can you approximate `carat` using the volume and the
    density of diamond?
    
1.  Log transforming `price` and `carat` makes the relationship between
    the two variables more clear (and suggests that there are a lot of missing
    expensive diamonds). There are at least three ways to perform this
    transformation. Brainstorm some approaches and briefly describe the pros
    and cons.
    
1.  List all related variables in `nycflights13::flights`.  Double check
    the value of `dep_delay`. Hint: you'll find the calculation easier if you
    compute "decimal hours", i.e. `hour + minutes / 60`. Rather than copying
    and pasting this calculation in multiple places, write a helper function.

## Challenges

1.  TODO. Baby names. geom_line + grouping. How to summarise? Include mutate that adds some interesting variables.
1.  diamonds-3

