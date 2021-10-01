#' A ggplot theme for swimlane plots
#'
#' @param extra_margin_r Number (of pt units) to add to right margin, most
#' often to account for text annotations
#' @param ... Further arguments to ggplot2::theme()
#'
#' @export
#'
#' @examples
#' patient_disposition %>%
#'   order_swimlane(subject, weeks_on_study, cohort) %>%
#'   ggplot2::ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   ggsci::scale_fill_jco() +
#'   theme_swimlane(legend.position = c(.8, .1)) +
#'   ggplot2::ggtitle("Time on study by subject") +
#'   ggplot2::ylab("Weeks on study")
theme_swimlane <- function(extra_margin_r = 15, ...) {
  ggplot2::theme_bw() +
  ggplot2::theme(
    plot.title.position = "plot",
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(7.5, 0, 0, 0, "pt")
    ),
    axis.title.y = ggplot2::element_blank(),
    legend.background = ggplot2::element_rect(
      fill="white", size = 0
    ),
    legend.title = ggplot2::element_blank(),
    plot.margin = ggplot2::margin(5.5, 5.5 + extra_margin_r, 5.5, 5.5, "pt"),
    ...
  )
}
