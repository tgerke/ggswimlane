#' A ggplot theme for swimlane plots
#'
#' A minimal horizontal-bar theme: no lane gridlines, light vertical
#' gridlines, no y-axis title, and legends along the bottom. Legend titles
#' are suppressed since swimlane legends (cohort fills, event symbols) are
#' typically self-explanatory; restore them via `...` if needed.
#'
#' @param base_size Base font size in pts, passed to
#'   [ggplot2::theme_minimal()].
#' @param extra_margin_r Extra right margin in pts, to make room for
#'   annotations that extend past the last bar (e.g. [geom_swimlane_label()]).
#' @param ... Further arguments passed to [ggplot2::theme()], overriding the
#'   defaults set here. For an inside legend, use
#'   `legend.position = "inside", legend.position.inside = c(x, y)`.
#'
#' @return A ggplot2 theme object.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(patient_disposition) +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   labs(x = "Weeks on study") +
#'   theme_swimlane()
theme_swimlane <- function(base_size = 11, extra_margin_r = 10, ...) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.title.position = "plot",
      plot.title = ggplot2::element_text(face = "bold"),
      plot.subtitle = ggplot2::element_text(colour = "grey30"),
      plot.caption = ggplot2::element_text(colour = "grey30"),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.minor.y = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(colour = "grey92"),
      axis.ticks = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(colour = "grey30"),
      axis.title.x = ggplot2::element_text(
        margin = ggplot2::margin(7.5, 0, 0, 0, "pt")
      ),
      legend.position = "bottom",
      legend.title = ggplot2::element_blank(),
      legend.background = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(5.5, 5.5 + extra_margin_r, 5.5, 5.5, "pt")
    ) +
    ggplot2::theme(...)
}
