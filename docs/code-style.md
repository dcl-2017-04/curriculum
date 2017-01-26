---
title: Code style
---

<!-- Generated automatically from code-style.yml. Do not edit by hand -->

# Code style
<small>(Leads to: [Reprexes](reprexes.md))</small>

Code style is simultaneously incredibly important and utterly trivial.
It'slikepunctuation: sureyoucanmakedowithoutit, but proper punctuation
can sure make things easier to read!

For pipelines (including ggplot2 plots), I recommend putting each statement
on a new line, ending each line with a `%>%` or `+` as appropriate.
Each line that continues a pipe should be indented by two spaces.
Include an empty line between different pipes and plots. Where possible
give your pipes an informative name: this will help you remember their
purpose when you come back to an analysis in the future.

## Readings

  * [Style guide](http://adv-r.had.co.nz/Style.html).
    The specific style you follow is not as important as picking a consistent
    style and sticking to it. When you're working with others, it's a really
    good idea to share a common style so that everyone can easily read and
    write the code. In this class, we'll use the style guide from "Advanced R".



