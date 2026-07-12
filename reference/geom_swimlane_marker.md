# Mark on-lane events with shaped points

Draws a shaped point on each lane at the time of an event (e.g. partial
response). Subjects with `NA` in `time_var` are skipped. Supply
`marker_label` to add the marker to the shared shape legend, or
`marker_var` to map several event types to different shapes.

## Usage

``` r
geom_swimlane_marker(
  id_var,
  time_var,
  marker_var = NULL,
  marker_label = NULL,
  size = 2.5,
  colour = "grey20",
  ...
)
```

## Arguments

- id_var:

  Column with the subject identifier, mapped to the y-axis.

- time_var:

  Numeric column with the event time, mapped to the x-axis. `NA` means
  no event for that subject.

- marker_var:

  Optional column mapped to shape, for data with several event types.
  Cannot be combined with `marker_label`.

- marker_label:

  Optional string naming this event in the shape legend (e.g.
  `"Partial response"`). Cannot be combined with `marker_var`.

- size:

  Point size.

- colour:

  Point color.

- ...:

  Other arguments passed to
  [`ggplot2::geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html).

## Value

A list containing a ggplot2 layer.

## Examples

``` r
library(ggplot2)

patient_disposition |>
  order_swimlane(subject, weeks_on_study, cohort) |>
  ggplot() +
  geom_swimlane(subject, weeks_on_study, cohort) +
  geom_swimlane_marker(
    subject, partial_response,
    marker_label = "Partial response"
  ) +
  labs(x = "Weeks on study") +
  theme_swimlane()
```
