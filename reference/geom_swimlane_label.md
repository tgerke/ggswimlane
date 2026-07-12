# Add text to the end of each swimlane bar

A text alternative to
[`geom_swimlane_status()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_status.md),
annotating each lane just past the end of its bar. Subjects with `NA` in
`label_var` are skipped.

## Usage

``` r
geom_swimlane_label(
  id_var,
  duration_var,
  label_var,
  size = 3,
  hjust = -0.15,
  colour = "grey30",
  ...
)
```

## Arguments

- id_var:

  Column with the subject identifier, mapped to the y-axis.

- duration_var:

  Numeric column with the bar length, mapped to the x-axis.

- label_var:

  Column with the annotation text.

- size:

  Text size.

- hjust:

  Horizontal justification; the small negative default nudges labels
  just past the bar end.

- colour:

  Text color.

- ...:

  Other arguments passed to
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html).

## Value

A list containing a ggplot2 layer.

## Examples

``` r
library(ggplot2)

patient_disposition |>
  order_swimlane(subject, weeks_on_study, cohort) |>
  ggplot() +
  geom_swimlane(subject, weeks_on_study, cohort) +
  geom_swimlane_label(subject, weeks_on_study, reason_off_study) +
  labs(x = "Weeks on study") +
  theme_swimlane(extra_margin_r = 40)
```
