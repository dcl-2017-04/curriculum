---
title: Syllabus
---

<!-- Generated automatically from syllabus.yml. Do not edit by hand -->

## Foundations {#foundations}

Learn the absolute essentials of data science as quickly as possible, so that
you can start performing authentic (if simple) analyses.

### Units

1. [Setup](setup.md)
1. [Data basics](data-basics.md)
1. [Data vis basics](vis-basics.md)
1. [Data manipulation basics](manip-basics.md)
1. [R Markdown basics](rmarkdown-basics.md)
1. [Code style](code-style.md)
1. [Documentation](documentation.md)

### Supplemental readings

* [Happy Git and GitHub for the useR](supplements.html#happy-git)
* [Expert data wrangling with R](supplements.html#grolemund-wrangle)
* [Data Visualisation in R with ggplot2](supplements.html#woo-vis)
* [Len Keifer's blog](supplements.html#keifer-blog)


## Exploratory data analysis {#eda}

Good data analysis involves fluid transitions between transformation and
visualisation. This week you'll first learn about the overall philosophy of
exploratory data analysis (EDA), and dive into the details of visual summaries
and transformations.

### Units

1. [Exploratory data analysis](eda.md)
1. [Missing values](missing-values.md)
1. [The grammar of graphics](vis-theory.md)
1. [Grouped summaries](vis-summaries.md)
1. [Visual transformations](vis-transformation.md)
1. [Getting help](getting-help.md)

### Supplemental readings

* [How humans see data](supplements.html#rauser-how-humans-see)
* [A Tale of Twenty-Two Million Citi Bike Rides: Analyzing the NYC Bike Share System](supplements.html#schneider-bikes)
* [Analyzing 1.1 Billion NYC Taxi and Uber Trips, with a Vengeance](supplements.html#schneider-taxis)


## Data essentials {#data-essentials}

This week is a grab bag of important data types and tools that will let you
explore more datasets. You'll get a broad overview of the most important
augmented vectors (date-times, strings, and factors), learn more about tidy
tibbles, master two important tools for tidying messy data, and learn about
joins, which allow you to combine multiple datasets.

### Units

1. [Date/time basics](datetime-basics.md)
1. [String basics](string-basics.md)
1. [Factor basics](factor-basics.md)
1. [Tidy tibbles](tidy-tibbles.md)
1. [Essentials of relational data](relational-basics.md)
1. [Spreading and gathering](spread-gather.md)

### Supplemental readings

* [Tidying computational biology models with biobroom](supplements.html#biobroom)
* [Non-tidy data](supplements.html#leek-non-tidy)
* [Tidy Data](supplements.html#wickham-tidy-data)


## Deepening your data skills {#deepening}

So far you've used tidy data that we've provided you. This will __never__
happen in real life, so this week you'll learn how to load data from a flat
files on disk, and more skills for working with data stored as text. We'll also
give you some skills for annotating and labelling your plots

### Units

1. [Parsing vectors](parse-vector.md)
1. [Parsing files](parse-file.md)
1. [Regular expressions](regexps.md)
1. [Separate and unite](separate-unite.md)
1. [Labelling your graphics](vis-labelling.md)
1. [Perception](vis-perception.md)

### Supplemental readings

* [Secrets of a happy graphing life](supplements.html#happy-graphing)


## Functions and iteration {#programming}

R is a programming language, and mastering the basics of programming will give
you powerful tools for automating your work. We've touched on basic functions
already, but this week, we'll focus on them, learning important skills for
automating your workflow.

### Units

1. [Atomic vectors](vectors.md)
1. [Vector functions](vector-functions.md)
1. [Lists](lists.md)
1. [Iteration](iteration.md)

### Supplemental readings

* [RStudio conference purrr tutorial](supplements.html#wickham-purrr)


## Miscellania {#misc}

A grab bag of things that we probably should've told you about previously but
somehow slipped Hadley's mind.

### Units

1. [Select and arrange](select-arrange.md)
1. [Summarise and mutate helpers](manip-helpers.md)
1. [Window functions](window-functions.md)
1. [Semi- and anti-joins](filter-joins.md)
1. [Debugging joins](joins-debugging.md)


## Modelling {#modelling}

Models are a useful tool for partitioning data into structure and what remains
(the residuals). Here you'll learn the basics of modelling and how you can
apply them to make sense of complex datasets.

### Units

1. [Model intuition](model-basics.md)
1. [Visualising models](model-vis.md)
1. [Models with multiple variables](model-multivariate.md)


## List columns {#list-cols}

Data frames are an extremely useful data structure, but so far have been
limited to containing atomic vectors. However, data frames can also contain
lists, and since you can put anything in a list, these allow you to extend the
data frame to contain any data structure. Here you'll learn the principles and
then see two applications.

### Units

1. [List columns](list-cols.md)
1. [Many models](model-many.md)
1. [Generating multiple reports](report-generation.md)


## Spatial data {#data-spatial}

Spatial data is not covered in R4DS, but it comes up in many analyses and it's
important to know the basics. This week you'll learn about the sf package and
how it interacts with the tidy tools you've learned so far.

### Units

1. [Spatial data basics](spatial-basics.md)
1. [Spatial visualisation](spatial-vis.md)


## Moving on {#onwards}

To finish up, we have a grab bag of topics that will help you share your data,
results, and problems with others. These tools will stand you in good stead as
you continue to master data science outside of this class.

### Units

1. [Exporting data](export.md)
1. [R Markdown presentations](rmarkdown-formats.md)
1. [Reprexes](reprexes.md)



