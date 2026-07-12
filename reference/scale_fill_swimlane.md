# Discrete scales for swimlane plots

Color and fill scales built on a reordered [Okabe-Ito
palette](https://jfly.uni-koeln.de/color/) (colorblind-safe, 8 colors),
and a shape scale of legible solid-first symbols (7 shapes). These are
applied automatically by
[`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md);
use them directly to style additional layers, or replace them with any
other discrete scale.

## Usage

``` r
scale_fill_swimlane(...)

scale_colour_swimlane(...)

scale_color_swimlane(...)

scale_shape_swimlane(...)
```

## Arguments

- ...:

  Arguments passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

## Value

A ggplot2 scale object.

## Examples

``` r
library(ggplot2)

ggplot(patient_disposition) +
  geom_swimlane(subject, weeks_on_study, cohort) +
  theme_swimlane()
```
