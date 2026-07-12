# Mark end-of-lane status with shaped points

Draws a shaped point at the end of each lane indicating the subject's
status (e.g. reason off study), with a legend generated automatically
from the shape mapping. Subjects still on study (`NA` in `status_var`,
or the value of `ongoing`) are drawn as a rightward arrow with its own
legend entry.

## Usage

``` r
geom_swimlane_status(
  id_var,
  duration_var,
  status_var,
  ongoing = "On study",
  arrow = TRUE,
  size = 2.5,
  colour = "grey20",
  ...
)
```

## Arguments

- id_var:

  Column with the subject identifier, mapped to the y-axis.

- duration_var:

  Numeric column with the lane length, mapped to the x-axis.

- status_var:

  Column with the status label. `NA` values are treated as ongoing.

- ongoing:

  Legend label for ongoing subjects; also recognized as a value of
  `status_var`.

- arrow:

  If `TRUE` (default), ongoing subjects get a rightward arrow with a
  separate legend entry. If `FALSE`, the `ongoing` label is treated as a
  regular status level in the shape legend.

- size:

  Point size; the ongoing arrow is drawn at `1.6 * size`.

- colour:

  Point color.

- ...:

  Other arguments passed to
  [`ggplot2::geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A list of ggplot2 layers (and, when `arrow = TRUE`, a scale that creates
the arrow's legend entry).

## Examples

``` r
library(ggplot2)

patient_disposition |>
  order_swimlane(subject, weeks_on_study, cohort) |>
  ggplot() +
  geom_swimlane(subject, weeks_on_study, cohort) +
  geom_swimlane_status(subject, weeks_on_study, reason_off_study) +
  labs(x = "Weeks on study") +
  theme_swimlane()
```
