# Discrete scales for swimlane plots

Color and fill scales built on a reordered [Okabe-Ito
palette](https://jfly.uni-koeln.de/color/) (colorblind-safe, 8 colors),
and a shape scale of legible closed symbols (8 shapes, solid first).
These are applied automatically by
[`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md);
use them directly to style additional layers, or replace them with any
other discrete scale.

## Usage

``` r
scale_fill_swimlane(...)

scale_colour_swimlane(...)

scale_color_swimlane(...)

scale_shape_swimlane(..., values = NULL)
```

## Arguments

- ...:

  Arguments passed to
  [`ggplot2::discrete_scale()`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

- values:

  Optional vector of shapes for `scale_shape_swimlane()`, named by level
  to pin statuses to shapes (as in
  [`ggplot2::scale_shape_manual()`](https://ggplot2.tidyverse.org/reference/scale_manual.html)).
  Defaults to the built-in palette.

## Value

A ggplot2 scale object.

## Details

By default shapes are assigned in factor-level order, so two plots with
different status levels assign different shapes to the same status. Pass
a named `values` vector to `scale_shape_swimlane()` to pin each status
to a shape across plots.

## Examples

``` r
library(ggplot2)

ggplot(patient_disposition) +
  geom_swimlane(subject, weeks_on_study, cohort) +
  theme_swimlane()
```
