
<!-- README.md is generated from README.Rmd. Please edit that file -->

# contribution - A Tiny Contribution Table Generator Based on ggplot2

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/ShixiangWang/contribution?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/contribution)
[![Travis build
status](https://travis-ci.org/openbiox/contribution.svg?branch=master)](https://travis-ci.org/openbiox/contribution)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/contribution)](https://cran.r-project.org/package=contribution)
[![](https://cranlogs.r-pkg.org/badges/grand-total/contribution?color=green)](https://cran.r-project.org/package=contribution)
<!-- badges: end -->

The goal of **contribution** is to generate **contribution table** for
credit assignment in a project. This is inspired by Nick Steinmetz (see
twitter
<https://twitter.com/SteinmetzNeuro/status/1147241138291527681>).

> Authors contributions sections are new and still don’t appear in major
> journals, but can be improved. Rather than text listing each author’s
> contributions, the same data can be presented as a table with rows
> corresponding to contributions and columns for each author.
>
> Advantages include:
>
> 1.  Graphics are faster and easier to comprehend. They are also easier
>     to locate in the document.
>
> 2.  This format can be readily augmented with additional information,
>     such as distinguishing between ‘major’ and ‘minor’ contributions
>     of each type.
>
> 3.  This format can be read as easily in either direction, answering
>     both “Who did X?” and “What did person Y do?” equally.
>
> 4.  This format lends itself to a nice extension for including your
>     author contribution information on your CV: a similar table where
>     each column is one of your papers.
>
> A difficulty with this is the diversity of terminology used, which
> would be helped by refinement and more widespread adoption of the
> CRediT framework (<https://casrai.org/credit/>).

## Feature

-   Support table type
    -   3-level contribution (i.e. ‘None’, ‘Minor’ and ‘Major’)
    -   numeric contribution
-   Dataset `palette` contains 27 color maps

An R Shiny application can be found at
<https://shiny.hiplot-academic.com/contribution-table/> or <https://shixiangwang.shinyapps.io/contribution/>. Corresponding source
code is available at
<https://github.com/ShixiangWang/shinyapps/tree/main/contribution-table>.

## Installation

You can install the released version of contribution from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("contribution")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("openbiox/contribution")
```

## Basic example

This is a basic example which shows you how to plot a simple
contribution table:

``` r
library(contribution)
data("demo")
demo
#> # A tibble: 5 × 4
#>   Class              WWP   NAS   TM   
#>   <chr>              <chr> <chr> <chr>
#> 1 Designed research  <NA>  Major Major
#> 2 Performed research <NA>  Major <NA> 
#> 3 Developed tool     Major Minor <NA> 
#> 4 Analyzed data      Major Minor Minor
#> 5 Wrote the paper    Major Minor Major
```

The accepted data format is a `data.frame` whose first column show the
`role` and the other columns show the people or projects. This format is
easy to create using R or other tools like Excel.

For a 3-level contribution table, only `Minor` and `Major` are valid, a
`NA` value should put in cell for no contribution.

``` r
generate(demo)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

The **white** box represents **no contribution**, the **grey** box
represents **minor contribution**, and the **black** box represents
**major contribution**.

The table is nice, easy to read. The result is a `ggplot` object, so you
can modify in your way!

You can also use other colors and `scale_fill_*` function from
**ggplot2** to map colors:

``` r
library(ggplot2)
generate(demo, text_angle_x = 20, color_map = scale_fill_brewer(palette ="Oranges"))
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

When it is not easy to see the meaning of color, you can show the
legend.

``` r
generate(demo, text_angle_x = 20, color_map = scale_fill_brewer(palette ="Set1"), show_legend = TRUE)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

More usage please see [online
documentation](https://openbiox.github.io/contribution/).

## To do

-   Support special symbol for indicating equal work in a project/paper
-   Accept author contributions information in machine-readable formats,
    e.g. in RIS and Bibtex citation documents provided on journal
    websites.
