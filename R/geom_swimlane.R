#' Swimlane bars
#'
#' The core layer of a swimlane plot: one horizontal bar per subject, with
#' subjects on the y-axis and duration on the x-axis. Optionally filled by a
#' grouping variable, either one row per subject (e.g. cohort) or several
#' rows per subject for stacked segments (e.g. treatment phases).
#'
#' @details
#' In addition to the bars, this function adds [scale_fill_swimlane()] (when
#' `fill_var` is supplied), [scale_shape_swimlane()] (shared by the
#' annotation layers such as [geom_swimlane_status()]), and
#' [ggplot2::coord_cartesian()] with `clip = "off"` so annotations may extend
#' into the plot margins. Adding your own fill or shape scale replaces the
#' built-in one; ggplot2 will print its standard message when that happens.
#'
#' @param id_var Column with the subject identifier, mapped to the y-axis.
#'   Use [order_swimlane()] first to control lane order.
#' @param duration_var Numeric column with the bar length, mapped to the
#'   x-axis.
#' @param fill_var Optional column mapped to bar fill. With one row per
#'   subject this colors whole lanes (e.g. by cohort); with multiple rows per
#'   subject the segments stack (e.g. treatment phases).
#' @param width Bar width.
#' @param position Position adjustment. The default stacks segments in
#'   factor-level order, so the first level of `fill_var` starts at zero.
#' @param ... Other arguments passed to [ggplot2::geom_col()].
#'
#' @return A list of ggplot2 layers, scales, and a coord.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition |>
#'   order_swimlane(subject, weeks_on_study, cohort) |>
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane()
geom_swimlane <- function(id_var, duration_var, fill_var = NULL, width = 0.6,
                          position = ggplot2::position_stack(reverse = TRUE),
                          ...) {
  id_quo <- rlang::enquo(id_var)
  duration_quo <- rlang::enquo(duration_var)
  fill_quo <- rlang::enquo(fill_var)
  has_fill <- !rlang::quo_is_null(fill_quo)

  quos <- list(id_quo, duration_quo)
  if (has_fill) {
    quos <- c(quos, list(fill_quo))
  }

  mapping <- if (has_fill) {
    ggplot2::aes(
      y = {{ id_var }}, x = {{ duration_var }}, fill = {{ fill_var }}
    )
  } else {
    ggplot2::aes(y = {{ id_var }}, x = {{ duration_var }})
  }

  c(
    list(
      ggplot2::geom_col(
        mapping = mapping,
        data = swim_layer_data(quos, "geom_swimlane"),
        width = width,
        position = position,
        ...
      )
    ),
    if (has_fill) {
      list(scale_fill_swimlane(guide = ggplot2::guide_legend(order = 1)))
    },
    list(
      scale_shape_swimlane(guide = ggplot2::guide_legend(order = 3)),
      ggplot2::coord_cartesian(clip = "off")
    )
  )
}
