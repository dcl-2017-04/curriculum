What to do when you are stuck
================
Jenny Bryan and Hadley Wickham

Help yourself
-------------

![](https://imgs.xkcd.com/comics/tech_support_cheat_sheet.png)

-   Carefully read the error message. Often it won't help, but sometimes there are hints that will help you get started.

-   If you encounter an error message you don't understand, strip anything highly specific (like your object or variable names), surround it with quotes and **google** it!

    (If the error message isn't in English, run `Sys.setenv(LANGUAGE = "en")` and re-run the code; you're more likely to find help for English error messages.)

-   Search [stackoverflow](http://stackoverflow.com) and include the `[r]` tag. Or the `[ggplot2]` tag. Or the `[dplyr]` tag. You get the idea.

Get help from others
--------------------

> If someone has the wit and knowledge to answer your question, they probably have other things they would like to do. Making your message clear, concise and user-friendly gives you the best hope of at least one of those strangers diverting their attention away from their life towards your problem.
>
> — The 9th circle of [The R Inferno](http://www.burns-stat.com/documents/books/the-r-inferno/)

If you do get to help from others, strive to create a **reprex**, a minimal reproducible example. There are three things you need to include to make your example reproducible: required packages, data, and code.

1.  **Packages** should be loaded at the top of the script, so it's easy to see which ones the example needs. This is a good time to check that you're using the latest version of each package; it's possible you've discovered a bug that's been fixed since you installed the package. For packages in the tidyverse, the easiest way to check is to run `tidyverse_update()`.

2.  The easiest way to include **data** in a question is to use `dput()` to generate the R code to recreate it. For example, to recreate the `mtcars` dataset in R, I'd perform the following steps:

    1.  Run `dput(mtcars)` in R
    2.  Copy the output
    3.  In my reproducible script, type `mtcars <-` then paste.

    Try and find the smallest subset of your data that still reveals the problem.

3.  Spend a little bit of time ensuring that your **code** is easy for others to read:

    -   Make sure you've used spaces and your variable names are concise, yet informative.

    -   Use comments to indicate where your problem lies.

    -   Do your best to remove everything that is not related to the problem.
        The shorter your code is, the easier it is to understand, and the easier it is to fix.

In the process of preparing your own reprex, you'll often find that you answer your own question. So it is a useful exercise even if you aren't ready to call in the experts yet. The process of stripping your problem down to its bare essence often reveals where the root issue lies.

### More resources on asking good questions

-   [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html), Eric Raymond and Rick Moen. You'll need a slightly thick skin, but they speak truth.

-   [How to Ask for Programming Help](http://codingkilledthecat.wordpress.com/2012/06/26/how-to-ask-for-programming-help/)

-   [How to ask](https://codereview.stackexchange.com/help/how-to-ask), Stack Exchange's

-   [What have you tried?](http://mattgemmell.com/what-have-you-tried/), Matt Gemmell.
