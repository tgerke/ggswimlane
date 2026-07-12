# Changelog

## ggswimlane 0.1.0

This release modernizes the package throughout. It is a breaking
release: plots built against 0.0.0.9000 will need updates.

### New features

- [`geom_swimlane_status()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_status.md)
  marks end-of-lane status (e.g. reason off study) with shaped points
  and an automatic legend, replacing text annotations as the recommended
  default; subjects still on study are drawn as a rightward arrow with
  its own legend entry
  ([\#2](https://github.com/tgerke/ggswimlane/issues/2),
  [\#3](https://github.com/tgerke/ggswimlane/issues/3)).
- [`geom_swimlane_marker()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_marker.md)
  marks on-lane events such as responses, with an optional entry in the
  shared shape legend.
- [`geom_swimlane_rug()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_rug.md)
  now draws shape-mapped points with a legend entry, and is documented
  honestly as a start-of-lane marker in the left margin
  ([\#1](https://github.com/tgerke/ggswimlane/issues/1),
  [\#2](https://github.com/tgerke/ggswimlane/issues/2)).
- [`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md)
  gains stacked-segment support: pass long data with a `fill_var` such
  as treatment phase and segments stack in factor-level order
  ([\#4](https://github.com/tgerke/ggswimlane/issues/4)). The new
  `weeks_on_treatment` column in `patient_disposition` and the gallery
  vignette demonstrate this.
- Plots now look polished without additional scales:
  [`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md)
  applies built-in colorblind-safe fill and shape scales (Okabe-Ito
  colors;
  [`scale_fill_swimlane()`](https://tgerke.github.io/ggswimlane/reference/scale_fill_swimlane.md),
  [`scale_colour_swimlane()`](https://tgerke.github.io/ggswimlane/reference/scale_fill_swimlane.md),
  [`scale_shape_swimlane()`](https://tgerke.github.io/ggswimlane/reference/scale_fill_swimlane.md)
  are also exported), and
  [`theme_swimlane()`](https://tgerke.github.io/ggswimlane/reference/theme_swimlane.md)
  was redesigned with a bottom legend default.
- All user-facing functions validate their column arguments and error
  informatively.

### Breaking changes

- ggplot2 \>= 3.5.0 and R \>= 4.1 are now required.
- [`geom_swimlane()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane.md)
  maps subjects to the y-axis natively instead of using
  [`coord_flip()`](https://ggplot2.tidyverse.org/reference/coord_flip.html);
  `cohort_var` is renamed `fill_var`.
- [`order_swimlane()`](https://tgerke.github.io/ggswimlane/reference/order_swimlane.md)
  now relevels the column passed as `id_var` rather than always writing
  the result to a column named `subject`.
- `geom_swimlane_text()` is removed; use
  [`geom_swimlane_status()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_status.md)
  or its text alternative
  [`geom_swimlane_label()`](https://tgerke.github.io/ggswimlane/reference/geom_swimlane_label.md),
  which passes `...` to the layer rather than treating them as
  aesthetics.
- The magrittr pipe re-export is removed; use the native pipe `|>`.
- The ggtext and lubridate dependencies are dropped.
