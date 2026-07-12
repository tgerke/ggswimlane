# Mark baseline characteristics in the left margin of a swimlane

Draws a shaped point at the start of each lane, in the margin to the
left of the bars, typically flagging a baseline characteristic such as
prior therapy. The shape mapping generates a legend entry automatically.
Subjects with `NA` in `rug_var` are skipped, so recode indicator columns
to a legend label or `NA`, e.g.
`dplyr::if_else(prior_drug == "Yes", "Prior therapy", NA)`.

## Usage

``` r
geom_swimlane_rug(
  id_var,
  rug_var,
  size = 2.3,
  colour = "grey20",
  fill = colour,
  stroke = 0.75,
  halo = "white",
  ...
)
```

## Arguments

- id_var:

  Column with the subject identifier, mapped to the y-axis.

- rug_var:

  Column with the legend label for flagged subjects and `NA` otherwise,
  mapped to shape.

- size:

  Point size.

- colour:

  Point color, used for both the outline and (by default) the fill of
  the glyph.

- fill:

  Fill color for the solid glyphs (shapes 21-25). Defaults to `colour`.

- stroke:

  Outline width of the glyph.

- halo:

  Color of the ring drawn beneath each glyph. Use `NA` to disable (e.g.
  on dark backgrounds).

- ...:

  Other arguments passed to
  [`ggplot2::geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A list containing a ggplot2 layer.

## Examples

``` r
library(ggplot2)

patient_disposition |>
  dplyr::mutate(
    prior_drug = dplyr::if_else(prior_drug == "Yes", "Prior therapy", NA)
  ) |>
  order_swimlane(subject, weeks_on_study, cohort) |>
  ggplot() +
  geom_swimlane(subject, weeks_on_study, cohort) +
  geom_swimlane_rug(subject, prior_drug) +
  labs(x = "Weeks on study") +
  theme_swimlane()
```
