# Okabe-Ito, reordered so the first two cohorts read as blue/orange
swim_colors <- c(
  "#0072B2", "#E69F00", "#009E73", "#CC79A7",
  "#D55E00", "#56B4E9", "#F0E442", "#999999"
)

# Solid shapes first for legibility at small marker sizes
swim_shapes <- c(16, 17, 15, 18, 3, 4, 8)

swim_pal <- function() {
  function(n) {
    if (n > length(swim_colors)) {
      cli::cli_warn(
        "The swimlane palette has {length(swim_colors)} colors but {n} are
         needed; colors will be recycled."
      )
      return(rep_len(swim_colors, n))
    }
    swim_colors[seq_len(n)]
  }
}

swim_shape_pal <- function() {
  function(n) {
    if (n > length(swim_shapes)) {
      cli::cli_warn(
        "The swimlane shape palette has {length(swim_shapes)} shapes but {n}
         are needed; shapes will be recycled."
      )
      return(rep_len(swim_shapes, n))
    }
    swim_shapes[seq_len(n)]
  }
}

#' Discrete scales for swimlane plots
#'
#' Color and fill scales built on a reordered [Okabe-Ito
#' palette](https://jfly.uni-koeln.de/color/) (colorblind-safe, 8 colors), and
#' a shape scale of legible solid-first symbols (7 shapes). These are applied
#' automatically by [geom_swimlane()]; use them directly to style additional
#' layers, or replace them with any other discrete scale.
#'
#' @param ... Arguments passed to [ggplot2::discrete_scale()].
#'
#' @return A ggplot2 scale object.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(patient_disposition) +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   theme_swimlane()
scale_fill_swimlane <- function(...) {
  ggplot2::discrete_scale("fill", palette = swim_pal(), ...)
}

#' @rdname scale_fill_swimlane
#' @export
scale_colour_swimlane <- function(...) {
  ggplot2::discrete_scale("colour", palette = swim_pal(), ...)
}

#' @rdname scale_fill_swimlane
#' @export
scale_color_swimlane <- scale_colour_swimlane

#' @rdname scale_fill_swimlane
#' @export
scale_shape_swimlane <- function(...) {
  ggplot2::discrete_scale("shape", palette = swim_shape_pal(), ...)
}
