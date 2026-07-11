#' Mark end-of-lane status with shaped points
#'
#' Draws a shaped point at the end of each lane indicating the subject's
#' status (e.g. reason off study), with a legend generated automatically from
#' the shape mapping. Subjects still on study (`NA` in `status_var`, or the
#' value of `ongoing`) are drawn as a rightward arrow with its own legend
#' entry.
#'
#' @param id_var Column with the subject identifier, mapped to the y-axis.
#' @param duration_var Numeric column with the lane length, mapped to the
#'   x-axis.
#' @param status_var Column with the status label. `NA` values are treated as
#'   ongoing.
#' @param ongoing Legend label for ongoing subjects; also recognized as a
#'   value of `status_var`.
#' @param arrow If `TRUE` (default), ongoing subjects get a rightward arrow
#'   with a separate legend entry. If `FALSE`, the `ongoing` label is treated
#'   as a regular status level in the shape legend.
#' @param size Point size; the ongoing arrow is drawn at `1.6 * size`.
#' @param colour Point color.
#' @param ... Other arguments passed to [ggplot2::geom_point()].
#'
#' @return A list of ggplot2 layers (and, when `arrow = TRUE`, a scale that
#'   creates the arrow's legend entry).
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition |>
#'   order_swimlane(subject, weeks_on_study, cohort) |>
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   geom_swimlane_status(subject, weeks_on_study, reason_off_study) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane()
geom_swimlane_status <- function(id_var, duration_var, status_var,
                                 ongoing = "On study", arrow = TRUE,
                                 size = 2.5, colour = "grey20", ...) {
  status_quo <- rlang::enquo(status_var)
  quos <- list(rlang::enquo(id_var), rlang::enquo(duration_var), status_quo)

  recode_status <- function(data) {
    status <- as.character(rlang::eval_tidy(status_quo, data))
    data$.swim_status <- dplyr::coalesce(status, ongoing)
    data
  }

  if (!arrow) {
    return(list(
      ggplot2::geom_point(
        mapping = ggplot2::aes(
          y = {{ id_var }}, x = {{ duration_var }},
          shape = .data$.swim_status
        ),
        data = swim_layer_data(quos, "geom_swimlane_status", recode_status),
        colour = colour,
        size = size,
        ...
      )
    ))
  }

  off_study <- swim_layer_data(quos, "geom_swimlane_status", function(data) {
    data <- recode_status(data)
    data[data$.swim_status != ongoing, , drop = FALSE]
  })
  on_study <- swim_layer_data(quos, "geom_swimlane_status", function(data) {
    data <- recode_status(data)
    data[data$.swim_status == ongoing, , drop = FALSE]
  })

  list(
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        y = {{ id_var }}, x = {{ duration_var }},
        shape = .data$.swim_status
      ),
      data = off_study,
      colour = colour,
      size = size,
      ...
    ),
    # A constant alpha mapping gives the arrow its own legend entry without
    # touching the shared shape scale; the key glyph inherits the arrow shape.
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        y = {{ id_var }}, x = {{ duration_var }},
        alpha = !!ongoing
      ),
      data = on_study,
      shape = "\u2192",
      colour = colour,
      size = size * 1.6,
      ...
    ),
    ggplot2::scale_alpha_manual(
      values = stats::setNames(1, ongoing),
      name = NULL,
      guide = ggplot2::guide_legend(order = 2)
    )
  )
}
