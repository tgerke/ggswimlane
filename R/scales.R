# Okabe-Ito, reordered so the first two cohorts read as blue/orange
swim_colors <- c(
  "#0072B2", "#E69F00", "#009E73", "#CC79A7",
  "#D55E00", "#56B4E9", "#F0E442", "#999999"
)

# swim_colors mixed 15% toward white, used for bar fills so the near-black
# markers stay dominant. Precomputed from
# round(col2rgb(swim_colors) * 0.85 + 255 * 0.15); worst adjacent-pair CVD
# separation stays above the deltaE 12 legibility floor.
swim_fills <- c(
  "#2687BE", "#EAAD26", "#26AD88", "#D48DB4",
  "#DB7626", "#6FBFEC", "#F2E85E", "#A8A8A8"
)

# Fillable shapes first (drawn solid via fill, with room for a halo ring),
# then open outlines. No line-only glyphs (+, x, *): their strokes read as
# arrow shafts or error bars when drawn at the end of a bar.
swim_shapes <- c(21, 24, 22, 23, 25, 1, 0, 5)

swim_pal <- function(colors = swim_colors) {
  force(colors)
  function(n) {
    if (n > length(colors)) {
      cli::cli_warn(
        "The swimlane palette has {length(colors)} colors but {n} are
         needed; colors will be recycled."
      )
      return(rep_len(colors, n))
    }
    colors[seq_len(n)]
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
#' a shape scale of legible symbols (8 shapes, solid first). The fill scale
#' uses a slight tint of the palette so that dark event markers stand out
#' against the bars; the color scale keeps the full-strength hues. These are
#' applied automatically by [geom_swimlane()]; use them directly to style
#' additional layers, or replace them with any other discrete scale.
#'
#' By default shapes are assigned in factor-level order, so two plots with
#' different status levels assign different shapes to the same status. Pass a
#' named `values` vector to `scale_shape_swimlane()` to pin each status to a
#' shape across plots.
#'
#' @param ... Arguments passed to [ggplot2::discrete_scale()].
#' @param values Optional vector of shapes for `scale_shape_swimlane()`,
#'   named by level to pin statuses to shapes (as in
#'   [ggplot2::scale_shape_manual()]). Defaults to the built-in palette.
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
  ggplot2::discrete_scale("fill", palette = swim_pal(swim_fills), ...)
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
scale_shape_swimlane <- function(..., values = NULL) {
  palette <- if (is.null(values)) {
    swim_shape_pal()
  } else {
    function(n) {
      if (is.null(names(values)) && n > length(values)) {
        cli::cli_abort(
          "{.arg values} has {length(values)} shape{?s} but {n} {?is/are}
           needed; name the values or supply enough shapes."
        )
      }
      values
    }
  }
  ggplot2::discrete_scale("shape", palette = palette, ...)
}
