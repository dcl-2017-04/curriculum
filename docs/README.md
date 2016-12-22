<!-- Generated automatically from syllabus.yml. Do not edit by hand -->

# Syllabus

## Foundations

Learn the absolute essentials of data science as quickly as possible, so that
you can start performing authentic (if simple) analyses.

### Units

1. [setup](setup.md)
1. [data-basics](data-basics.md)
1. [vis-basics](vis-basics.md)
1. [manip-basics](manip-basics.md)
1. [rmarkdown-basics](rmarkdown-basics.md)

### Challenges

1.  diamonds-1
1.  diamonds-2
1.  TODO. practice whole process including sync to github

### Supplemental readings

  * [How humans see data, by John Rauser](http://www.slideshare.net/JohnRauser/how-humans-see-data).
    (will be available in video form once O'Reilly edits videos)

  * [Getting started with ggplot2](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_2) [ggplot2-2].
    This covers similar ground to the readings in R4DS.

  * [Data transformation](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_10) [ggplot2-10].
    This covers similar ground to the readings in R4DS.

  * [Expert data wrangling with R, by Garrett Grolemund](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491917046) [safari].
    A video introduction to dplyr.

  * [Data Visualisation in R with ggplot2, by Kara Woo](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491963661) [safari].
    A video introduction to ggplot2.

  * [Getting Started with R Markdown](https://www.rstudio.com/resources/webinars/getting-started-with-r-markdown/).
    This 60 minute webinar introduces you to R Markdown. It covers similar
    content to the readings in video form.



## Exploratory data analysis

Good data analysis involves fluid transitions between transformation and
visualisation. This week you'll first learn about the overall philosophy of EDA
(exploratory data analysis), and then dive into the details of data summaries
and transformations.

### Units

1. [eda](eda.md)
1. [data-summaries](data-summaries.md)
1. [function-summary](function-summary.md)
1. [data-transformations](data-transformations.md)

### Challenges

1.  TODO. Baby names. geom_line + grouping. How to summarise? Include mutate that adds some interesting variables.
1.  diamonds-3

### Supplemental readings

  * [A Tale of Twenty-Two Million Citi Bike Rides: Analyzing the NYC Bike Share System](http://toddwschneider.com/posts/a-tale-of-twenty-two-million-citi-bikes-analyzing-the-nyc-bike-share-system/).
    This analysis by Todd W. Schneider uses R (along with other tools) to
    analyse over 20 million bike rides in NYC. As you read through the analysis
    think how you would do it yourself using the techniques you have learned so
    far.

  * [Analyzing 1.1 Billion NYC Taxi and Uber Trips, with a Vengeance](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/).
    This analysis, also by Todd W. Schneider, uses much more data than the
    previous analysis. What additional challenges did Todd need to solve to
    allow him to work with this much data?



## Care and feeding of tibbles

So far you've used tidy data that we've provided you. This will __never__
happen in real life, so this week you'll learn how to load data from a flat
files on disk, and get your data into a tidy form. We'll also touch on some
important theory about the R's data structures.

### Units

1. [tidy](tidy.md)
1. [import](import.md)
1. [missing-values](missing-values.md)
1. [data-structures](data-structures.md)


## Functions and iteration

R is a programming language, and mastering the basics of programming will give
you powerful tools for automating your work. We've touched on basic functions
already, but this week, we'll focus on them, learning important skills for
automating your workflow.


## Date/times and relational data

This week we'll learn how to handle date/time data, and multiple related table
(relational data). This will allow us to fully explore the datasets in
nycflights13, and start to learn how weather is related to flight delays.


## Strings and factors

There are two important types of variable that we haven't covered in detail
yet: strings and factors. You'll also learn about regular expression which are
a special, compact, language for describing patterns in strings.

### Challenges

1.  neiss


## Modelling




## Hierarchical data with purrr




## Text data with tidytext




## Spatial data with sf





