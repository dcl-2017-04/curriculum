<!-- Generated automatically from index.yaml. Do not edit by hand -->
# Exploratory data analysis

Good data analysis involves fluid transitions between transformation and visualisation. This week you'll practice those tools by using them for EDA (exploratory data analysis), and diving into some of the details of dplyr and ggplot2 that we elided last week.
Here we apply these tools to small (in-memory) data, but they're still useful when you have big (out-of-memory) data. That's because a powerful strategy for working with big data is to make it small with some combination of subetting, summarising, or sampling.

## EDA

Exploratory data analysis is partly a set of techniques, but is mostly a mindset: you want to remain open to what the data is telling you. You'll learn the techniques in the readings, and then practice the mindset in class and in the challenges.

### Readings

  * [Introduction](http://r4ds.had.co.nz/exploratory-data-analysis.html#introduction-3) [r4ds-7.1]
  * [Questions](http://r4ds.had.co.nz/exploratory-data-analysis.html#questions) [r4ds-7.2]
  * [Variation](http://r4ds.had.co.nz/exploratory-data-analysis.html#variation) [r4ds-7.3]
  * [Covariation](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation) [r4ds-7.5]

### Supplemental readings

  * [A Tale of Twenty-Two Million Citi Bike Rides: Analyzing the NYC Bike Share System](http://toddwschneider.com/posts/a-tale-of-twenty-two-million-citi-bikes-analyzing-the-nyc-bike-share-system/)

     This analysis by Todd W. Schneider uses R (along with other tools) to analyse over 20 million bike rides in NYC. As you read through the analysis think how you would do it yourself using the techniques you have learned so far.

  * [Analyzing 1.1 Billion NYC Taxi and Uber Trips, with a Vengeance](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/)

     This analysis, also by Todd W. Schneider, uses much more data than the previous analysis. What additional challenges did Todd need to solve to allow him to work with this data?


## dplyr details

Now that you have some experience with dplyr, we'll fill in the blanks with a more sysematic exploration of the options.

### Readings

  * [Data transformation](http://r4ds.had.co.nz/transform.html) [r4ds-5]
  * [Data Wrangling Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) [cheatsheets-data-wrangling]

### Supplemental readings

  * [Pipes](http://r4ds.had.co.nz/pipes.html) [r4ds-18]

## ggplot2 details

Now that you have some experience with ggplot2, we'll fill in the blanks with a more systematic exploration of the details. Read Chapters 4 and 5 to get a

### Readings

  * [Mastering the grammar](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_4) [ggplot2-4]
  * [Build a plot layer by layer](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_5) [ggplot2-5]
  * [Scales, axes and legends](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_6) [ggplot2-6]
  * [Data Visualization Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf) [cheatsheets-ggplot2-2.1]

