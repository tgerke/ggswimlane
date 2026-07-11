#' Mark baseline characteristics in the left margin of a swimlane
#'
#' Draws a shaped point at the start of each lane, in the margin to the left
#' of the bars, typically flagging a baseline characteristic such as prior
#' therapy. The shape mapping generates a legend entry automatically.
#' Subjects with `NA` in `rug_var` are skipped, so recode indicator columns
#' to a legend label or `NA`, e.g.
#' `dplyr::if_else(prior_drug == "Yes", "Prior therapy", NA)`.
#'
#' @param id_var Column with the subject identifier, mapped to the y-axis.
#' @param rug_var Column with the legend label for flagged subjects and `NA`
#'   otherwise, mapped to shape.
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
#'   dplyr::mutate(
#'     prior_drug = dplyr::if_else(prior_drug == "Yes", "Prior therapy", NA)
#'   ) |>
#'   order_swimlane(subject, weeks_on_study, cohort) |>
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   geom_swimlane_rug(subject, prior_drug) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane()
geom_swimlane_rug <- function(id_var, rug_var, size = 2, colour = "grey20", ...) {
  rug_quo <- rlang::enquo(rug_var)
  quos <- list(rlang::enquo(id_var), rug_quo)

  list(
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        y = {{ id_var }}, x = -Inf, shape = {{ rug_var }}
      ),
      data = swim_layer_data(
        quos, "geom_swimlane_rug", swim_drop_na(rug_quo)
      ),
      colour = colour,
      size = size,
      ...
    )
  )
}
