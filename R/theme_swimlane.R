#' A ggplot theme for swimlane plots
#'
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
#'   ggplot2::ylab("\nWeeks on study")
theme_swimlane <- function(...) {
  ggplot2::theme_bw() +
  ggplot2::theme(
    plot.title.position = "plot",
    panel.grid.major.y = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.title.y = ggplot2::element_blank(),
    legend.background = ggplot2::element_rect(
      fill="white", size = 0
    ),
    legend.title = ggplot2::element_blank(),
    ...
  )
}
