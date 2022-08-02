#' Add a rug to the right-hand margin of a swimlane
#'
#' @param x Typically a subject identifier
#' @param hjust Used to adjust position in the margin
#' @param vjust Used to adjust vertical position in the margin
#' @param label_var Variable with the desired symbol or text annotation
#' @param labels A named vector transforming label_var to symbols (currently not used)
#' @param color Label colors (will accept a vector when the labels arg is activated)
#' @param ... Further arguments to ggtext::geom_richtext()
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition %>%
#'   dplyr::mutate(
#'     reason_off_study = tidyr::replace_na(reason_off_study, "&#8594;"),
#'     prior_drug = dplyr::case_when(
#'       prior_drug == "Yes"~ "&#9658;",
#'       TRUE ~ NA_character_
#'     )
#'   ) %>%
#'   order_swimlane(subject, weeks_on_study, cohort) %>%
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   ggsci::scale_fill_jco() +
#'   geom_swimlane_text(subject, weeks_on_study, reason_off_study) +
#'   geom_point(
#'     aes(x = subject, y = partial_response),
#'     na.rm = TRUE
#'   ) +
#'   geom_swimlane_rug(x = subject, label_var = prior_drug, color = "#CD534C") +
#'   theme_swimlane(legend.position = c(.8, .1)) +
#'   ggtitle("Time on study by subject") +
#'   ylab("Weeks on study")
geom_swimlane_rug <- function(x, hjust = 1, vjust = .5, label_var, labels = NULL, color = "black", ...) {
  x <- rlang::enexpr(x)
  label_var <- rlang::enexpr(label_var)

  ggtext::geom_richtext(
    ggplot2::aes(x = .data[[x]], y = 0, label = .data[[label_var]]),
    color = color,
    hjust = hjust,
    vjust = vjust,
    fill = NA,
    label.color = NA,
    label.padding = grid::unit(rep(0, 4), "pt"),
    na.rm = TRUE
  )

}
