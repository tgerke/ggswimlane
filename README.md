
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggswimlane

<!-- badges: start -->
<!-- badges: end -->

ggswimlane is a ggplot wrapper that simplifies the construction of
swimlane plots, which are a common tool for showing patient trajectories
through a clinical trial.

## Installation

You can install the released version of ggswimlane from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tgerke/ggswimlane")
```

## Example

``` r
library(ggswimlane)

dplyr::glimpse(patient_disposition)
#> Rows: 20
#> Columns: 6
#> $ subject          <chr> "339057", "751377", "297647", "992253", "542555", "98…
#> $ weeks_on_study   <dbl> 70.3153450, 31.1616594, 42.6181308, 22.7623721, 64.91…
#> $ cohort           <chr> "Cohort A", "Cohort B", "Cohort B", "Cohort A", "Coho…
#> $ reason_off_study <chr> "Physician decision", "Withdrawal by subject", "Disea…
#> $ prior_drug       <chr> "Yes", "No", "Yes", "Yes", "Yes", "Yes", "No", "Yes",…
#> $ partial_response <dbl> 35.729492, NA, NA, NA, NA, 10.789094, NA, 26.134307, …
```
