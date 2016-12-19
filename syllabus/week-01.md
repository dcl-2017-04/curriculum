<!-- Generated automatically from syllabus.yml. Do not edit by hand -->
# Foundations (Week 1)

Learn the absolute essentials of data science as quickly as possible, so that
you can start performing authentic (if simple) analyses.

## Setup
(estimated duration: 45 mins)

Ensure that you have all the tools to need for this class.

### Readings

  * [Prerequisites](http://r4ds.had.co.nz/introduction.html#prerequisites) [r4ds-1.4]
  * [Running R code](http://r4ds.had.co.nz/introduction.html#running-r-code) [r4ds-1.5]
  * [RStudio IDE Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf) [cheatsheets-rstudio-IDE]

    You don't need to read the complete cheatsheet, but you should know that it
    exists.


## Exercises

1.  Run `library(tidyverse)`. What are the core packages in the tidyverse?
    
1.  What do the following keyboard shortcuts do? When should you use them?
    
    - `Cmd/Ctrl + Enter` (in the script editor)
    - `Cmd/Ctrl + Up arrow` (in the console)
    - `Cmd/Ctrl + Shift + F10` (anywhere)
    
### Supplemental readings

  * [http://stat545.com/block000_r-rstudio-install.html](http://stat545.com/block000_r-rstudio-install.html)
  * [http://happygitwithr.com](http://happygitwithr.com)

    Refer to the first two parts of this book ("Installation" and "Connect Git,
    GitHub, RStudio" if you have problems getting set up with Git and Github.



## Data science workflow

Experience the full data science workflow by creating an RMarkdown file,
running some R code, and uploading the results to GitHub.

### Readings

  * [Introduction](http://r4ds.had.co.nz/r-markdown.html#introduction-18) [r4ds-27.1]
  * [R Markdown basics](http://r4ds.had.co.nz/r-markdown.html#r-markdown-basics) [r4ds-27.2]
  * [Code chunks](http://r4ds.had.co.nz/r-markdown.html#code-chunks) [r4ds-27.4]
  * [Introduction](http://r4ds.had.co.nz/data-visualisation.html#introduction-1) [r4ds-3.1]
  * [First steps](http://r4ds.had.co.nz/data-visualisation.html#first-steps) [r4ds-3.2]
  * GitHub process [TODO]
  * working directories [TODO]

### Supplemental readings

  * [Getting Started with R Markdown.](https://www.rstudio.com/resources/webinars/getting-started-with-r-markdown/)


## Data science basics
(estimated duration: 90 mins)

Data transformation and visualisation are the most important data science
tools. You'll learn them first using tidy data (column = variable, row = case)
that we provide.

### Readings

  * [Aesthetic mappings](http://r4ds.had.co.nz/data-visualisation.html#aesthetic-mappings) [r4ds-3.3]
  * [Facets](http://r4ds.had.co.nz/data-visualisation.html#facets) [r4ds-3.5]
  * [Filter rows with filter()](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) [r4ds-5.2]
  * [Add new variables with mutate()](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate) [r4ds-5.5]
  * [Grouped summaries with summarise()](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) [r4ds-5.6]
  * [Toolbox](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_3) [ggplot2-3]

    Skim this chapter so you're aware of the most important ggplot2 tools. Come
    back and read in detail when you actually need to use them.


## Exercises

1.  What’s gone wrong with this plot? Why are the points not blue?
    
    ```{r}
    ggplot(data = mpg) +
      geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
    ```
    
1.  What's gone wrong with this plot? Why is there only one histogram?
    
    ```{r}
    ggplot(data = mpg) +
      geom_boxplot(mapping = aes(x = cyl, y = displ))
    ```
    
1.  Which variables in `mpg` are categorical? Which variables are continuous?
    Map a continuous variable to color, size, and shape. How do these
    aesthetics behave differently for categorical vs. continuous variables?
    
1.  How does engine displacement vary with number of cylinders?
    Draw a plot with ggplot2. Compute a numeric summary with ggplot2.
    Create a new variable that gives the displacement per cylinder.
    Visualise with ggplot2.
    
1.  How does the relationship between `displ` and `cyl` vary with `drv`?
    Show three plots and write a one paragrah summary. There are a handful of
    cars with 5 cylinders. Remove them before drawing your plots.
    Describe three things that you'd like to do to improve your plots but you
    don't know how yet.
    
### Supplemental readings

  * [How humans see data, by John Rauser](http://www.slideshare.net/JohnRauser/how-humans-see-data)

    (will be available in video form once O'Reilly edits videos)

  * [Getting started with ggplot2](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_2) [ggplot2-2]
  * [Data transformation](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_10) [ggplot2-10]
  * [Expert data wrangling with R, by Garrett Grolemund](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491917046) [safari]
  * [Data Visualisation in R with ggplot2, by Kara Woo](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491963661) [safari]


## Challenges

1.  diamonds-1
1.  diamonds-2
1.  TODO. practice whole process including sync to github

