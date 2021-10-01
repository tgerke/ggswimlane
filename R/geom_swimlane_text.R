#' Add text to the end of each swimlane bar
#'
#' Most often used to annotate each bar with reason for ending study
#' or, if applicable, active status.
#'
#' @param x Typically subject identifier
#' @param y Typically duration on study
#' @param label Annotation text
#' @param ... Other options passed to ggtext::geom_richtext
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition %>%
#'   dplyr::mutate(
#'     reason_off_study = tidyr::replace_na(reason_off_study, "&#8594;")
#'   ) %>%
#'   order_swimlane(subject, weeks_on_study, cohort) %>%
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   ggsci::scale_fill_jco() +
#'   geom_swimlane_text(subject, weeks_on_study, reason_off_study) +
#'   theme_swimlane(
#'     legend.position = c(.9, .1),
#'     axis.title.x = element_blank()
#'   )
geom_swimlane_text <- function(x, y, label, ...) {

  x <- rlang::enexpr(x)
  y <- rlang::enexpr(y)
  label <- rlang::enexpr(label)

  ggtext::geom_richtext(
    ggplot2::aes(
      x = .data[[x]], y = .data[[y]], label = .data[[label]],
      ...
    ),
    hjust = 0,
    size = 2,
    label.size = 0,
    na.rm = TRUE
  )

}
