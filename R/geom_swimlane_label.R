#' Add text to the end of each swimlane bar
#'
#' A text alternative to [geom_swimlane_status()], annotating each lane just
#' past the end of its bar. Subjects with `NA` in `label_var` are skipped.
#'
#' @param id_var Column with the subject identifier, mapped to the y-axis.
#' @param duration_var Numeric column with the bar length, mapped to the
#'   x-axis.
#' @param label_var Column with the annotation text.
#' @param size Text size.
#' @param hjust Horizontal justification; the small negative default nudges
#'   labels just past the bar end.
#' @param colour Text color.
#' @param ... Other arguments passed to [ggplot2::geom_text()].
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
#'   geom_swimlane_label(subject, weeks_on_study, reason_off_study) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane(extra_margin_r = 40)
geom_swimlane_label <- function(id_var, duration_var, label_var, size = 3,
                                hjust = -0.15, colour = "grey30", ...) {
  label_quo <- rlang::enquo(label_var)
  quos <- list(rlang::enquo(id_var), rlang::enquo(duration_var), label_quo)

  list(
    ggplot2::geom_text(
      mapping = ggplot2::aes(
        y = {{ id_var }}, x = {{ duration_var }}, label = {{ label_var }}
      ),
      data = swim_layer_data(
        quos, "geom_swimlane_label", swim_drop_na(label_quo)
      ),
      hjust = hjust,
      size = size,
      colour = colour,
      ...
    )
  )
}
