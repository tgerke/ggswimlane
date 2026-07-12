# Order a tibble for swimlane plotting

Relevels an identifying column (often subject ID) as a factor ordered by
a second variable (often study duration), with the option to perform
this sorting within groups. Run before
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html) +
[`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md)
so lanes appear shortest-to-longest from the bottom up.

## Usage

``` r
order_swimlane(.data, id_var, order_by, order_within = NULL)
```

## Arguments

- .data:

  A tibble or data.frame.

- id_var:

  Row (often subject) ID; releveled in place.

- order_by:

  Numeric variable to sort by, often time on study.

- order_within:

  Optional variable to sort within, often cohort.

## Value

`.data` with `id_var` releveled as an ordered factor.

## Examples

``` r
patient_disposition |>
  order_swimlane(subject, weeks_on_study, cohort)
#> # A tibble: 20 × 7
#>    subject weeks_on_study cohort   reason_off_study  prior_drug partial_response
#>    <fct>            <dbl> <chr>    <chr>             <chr>                 <dbl>
#>  1 980129          15.0   Cohort B Withdrawal by su… Yes                   10.8 
#>  2 986548          26.9   Cohort B Withdrawal by su… No                    NA   
#>  3 223561          27.5   Cohort B Physician decisi… Yes                   26.1 
#>  4 751377          31.2   Cohort B Withdrawal by su… No                    NA   
#>  5 297647          42.6   Cohort B Disease progress… Yes                   NA   
#>  6 321235          64.7   Cohort B Adverse event     No                    NA   
#>  7 226603          74.4   Cohort B Disease progress… No                    NA   
#>  8 361221          78.7   Cohort B Completed         Yes                   60.2 
#>  9 460588          79.6   Cohort B NA                Yes                   NA   
#> 10 158396           0.186 Cohort A Adverse event     Yes                   NA   
#> 11 992253          22.8   Cohort A Adverse event     Yes                   NA   
#> 12 828351          40.9   Cohort A Disease progress… Yes                    8.82
#> 13 467205          52.5   Cohort A Disease progress… Yes                   44.6 
#> 14 542555          64.9   Cohort A Disease progress… Yes                   NA   
#> 15 339057          70.3   Cohort A Physician decisi… Yes                   35.7 
#> 16 690585          72.2   Cohort A Adverse event     Yes                   52.2 
#> 17 465452          86.4   Cohort A NA                No                    67.3 
#> 18 337310          86.5   Cohort A Completed         No                    NA   
#> 19 494306          87.6   Cohort A NA                Yes                    8.26
#> 20 482665          94.2   Cohort A Completed         No                    NA   
#> # ℹ 1 more variable: weeks_on_treatment <dbl>
```
