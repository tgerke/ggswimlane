# A ggplot theme for swimlane plots

A minimal horizontal-bar theme: no lane gridlines, light vertical
gridlines, no y-axis title, and legends along the bottom. Legend titles
are suppressed since swimlane legends (cohort fills, event symbols) are
typically self-explanatory; restore them via `...` if needed.

## Usage

``` r
theme_swimlane(base_size = 11, extra_margin_r = 10, ...)
```

## Arguments

- base_size:

  Base font size in pts, passed to
  [`ggplot2::theme_minimal()`](https://ggplot2.tidyverse.org/reference/ggtheme.html).

- extra_margin_r:

  Extra right margin in pts, to make room for annotations that extend
  past the last bar (e.g.
  [`geom_swimlane_label()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_label.md)).

- ...:

  Further arguments passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html),
  overriding the defaults set here. For an inside legend, use
  `legend.position = "inside", legend.position.inside = c(x, y)`.

## Value

A ggplot2 theme object.

## Examples

``` r
library(ggplot2)

ggplot(patient_disposition) +
  geom_swimlane(subject, weeks_on_study, cohort) +
  labs(x = "Weeks on study") +
  theme_swimlane()
```
