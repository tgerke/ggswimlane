#' Order a tibble for swimlane plotting
#'
#' Relevels an identifying column (often subject ID) as a factor ordered by a
#' second variable (often study duration), with the option to perform this
#' sorting within groups. Run before [ggplot2::ggplot()] +
#' [geom_swimlane()] so lanes appear shortest-to-longest from the bottom up.
#'
#' @param .data A tibble or data.frame.
#' @param id_var Row (often subject) ID; releveled in place.
#' @param order_by Numeric variable to sort by, often time on study.
#' @param order_within Optional variable to sort within, often cohort.
#'
#' @return `.data` with `id_var` releveled as an ordered factor.
#' @export
#'
#' @examples
#' patient_disposition |>
#'   order_swimlane(subject, weeks_on_study, cohort)
order_swimlane <- function(.data, id_var, order_by, order_within = NULL) {
  id_sym <- rlang::ensym(id_var)
  by_quo <- rlang::enquo(order_by)
  within_quo <- rlang::enquo(order_within)

  cols <- c(
    rlang::as_name(id_sym),
    quo_col_name(by_quo),
    if (!rlang::quo_is_null(within_quo)) quo_col_name(within_quo)
  )
  check_swimlane_cols(.data, cols, "order_swimlane")

  if (!is.numeric(dplyr::pull(.data, {{ order_by }}))) {
    cli::cli_abort(
      "{.arg order_by} must be a numeric column.",
      call = NULL
    )
  }

  # Sort without groups
  if (rlang::quo_is_null(within_quo)) {
    return(
      .data |>
        dplyr::mutate(
          !!id_sym := stats::reorder(factor(!!id_sym), {{ order_by }})
        )
    )
  }

  .data |>
    dplyr::arrange(dplyr::desc({{ order_within }}), {{ order_by }}) |>
    dplyr::mutate(
      !!id_sym := stats::reorder(factor(!!id_sym), dplyr::row_number())
    )
}
