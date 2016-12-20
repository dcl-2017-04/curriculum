# Data science basics
(estimated duration: 90 mins)

Data transformation and visualisation are the most important tools for data
science. You'll learn them first using tidy data (column = variable, row =
case) that we give you. Later, you'll learn how to apply them to your own data.

## Readings

  * [Aesthetic mappings](http://r4ds.had.co.nz/data-visualisation.html#aesthetic-mappings) [r4ds-3.3]
  * [Facets](http://r4ds.had.co.nz/data-visualisation.html#facets) [r4ds-3.5]
  * [Filter rows with filter()](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) [r4ds-5.2]
  * [Add new variables with mutate()](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate) [r4ds-5.5]
  * [Grouped summaries with summarise()](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) [r4ds-5.6]
  * [Toolbox](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_3) [ggplot2-3].
    Skim this chapter so you're aware of the most important ggplot2 tools. Come
    back and read in detail when you actually need to use them.


## Exercises

1.  What’s gone wrong with this plot? Why are the points not blue?
    
    ```R
    ggplot(data = mpg) +
      geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
    ```
    
1.  What's gone wrong with this plot? Why is there only one boxplot?
    
    ```R
    ggplot(data = mpg) +
      geom_boxplot(mapping = aes(x = cyl, y = displ))
    ```
    
1.  Which variables in `mpg` are categorical? Which variables are continuous?
    Map a continuous variable to color, size, and shape. How do these
    aesthetics behave differently for categorical vs. continuous variables?
    
1.  How does engine displacement vary with number of cylinders?
    Draw a plot with ggplot2. Compute a numeric summary with dplyr.
    What are the pros and cons of a plot vs. a numeric summary?
    
1.  Create a new variable that gives the displacement per cylinder.
    How does it vary across classes. Visualise with ggplot2.
    
1.  How does the relationship between `displ` and `cyl` vary with `drv`?
    There are a handful of cars with 5 cylinders. Remove them before drawing
    your plots.
    
    Show three plots and write a one paragrah summary. Describe three
    improvements that you'd like to make to your plots, but you don't know how.
    

## Supplemental readings

  * [How humans see data, by John Rauser](http://www.slideshare.net/JohnRauser/how-humans-see-data).
    (will be available in video form once O'Reilly edits videos)

  * [Getting started with ggplot2](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_2) [ggplot2-2].
    This covers similar ground to the readings in R4DS.

  * [Data transformation](http://link.springer.com.ezproxy.stanford.edu/chapter/10.1007/978-3-319-24277-4_10) [ggplot2-10].
    This covers similar ground to the readings in R4DS.

  * [Expert data wrangling with R, by Garrett Grolemund](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491917046) [safari].
    This is a video introduction to dplyr.

  * [Data Visualisation in R with ggplot2, by Kara Woo](http://proquest.safaribooksonline.com.ezproxy.stanford.eduvideo/programming/r/9781491963661) [safari].
    This is a video introduction to ggplot2.



