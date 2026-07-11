#' Mark on-lane events with shaped points
#'
#' Draws a shaped point on each lane at the time of an event (e.g. partial
#' response). Subjects with `NA` in `time_var` are skipped. Supply
#' `marker_label` to add the marker to the shared shape legend, or
#' `marker_var` to map several event types to different shapes.
#'
#' @param id_var Column with the subject identifier, mapped to the y-axis.
#' @param time_var Numeric column with the event time, mapped to the x-axis.
#'   `NA` means no event for that subject.
#' @param marker_var Optional column mapped to shape, for data with several
#'   event types. Cannot be combined with `marker_label`.
#' @param marker_label Optional string naming this event in the shape legend
#'   (e.g. `"Partial response"`). Cannot be combined with `marker_var`.
#' @param size Point size.
#' @param colour Point color.
#' @param ... Other arguments passed to [ggplot2::geom_point()].
#'
#' @return A list containing a ggplot2 layer.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition |>
#'   order_swimlane(subject, weeks_on_study, cohort) |>
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   geom_swimlane_marker(
#'     subject, partial_response,
#'     marker_label = "Partial response"
#'   ) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane()
geom_swimlane_marker <- function(id_var, time_var, marker_var = NULL,
                                 marker_label = NULL, size = 2.5,
                                 colour = "grey20", ...) {
  time_quo <- rlang::enquo(time_var)
  marker_quo <- rlang::enquo(marker_var)
  has_marker_var <- !rlang::quo_is_null(marker_quo)

  if (has_marker_var && !is.null(marker_label)) {
    cli::cli_abort(
      "Supply only one of {.arg marker_var} or {.arg marker_label}."
    )
  }

  quos <- list(rlang::enquo(id_var), time_quo)
  if (has_marker_var) {
    quos <- c(quos, list(marker_quo))
  }

  mapping <- if (has_marker_var) {
    ggplot2::aes(
      y = {{ id_var }}, x = {{ time_var }}, shape = {{ marker_var }}
    )
  } else if (!is.null(marker_label)) {
    ggplot2::aes(
      y = {{ id_var }}, x = {{ time_var }}, shape = !!marker_label
    )
  } else {
    ggplot2::aes(y = {{ id_var }}, x = {{ time_var }})
  }

  list(
    ggplot2::geom_point(
      mapping = mapping,
      data = swim_layer_data(
        quos, "geom_swimlane_marker", swim_drop_na(time_quo)
      ),
      colour = colour,
      size = size,
      ...
    )
  )
}
