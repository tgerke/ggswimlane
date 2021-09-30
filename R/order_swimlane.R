#' Order a tibble for swimlane plotting
#'
#' Assigns factor levels to an identifying key in a tibble (often subject ID)
#' by a second variable (often study duration), with the option to perform
#' this sorting within groups. Most often used before a call to ggplot() +
#' geom_swimlane()
#'
#' @param .data A tibble or data.frame
#' @param id_var Row (often subject) ID
#' @param order_by Variable to sort by, often time on study
#' @param order_within Variable to sort within, often cohort
#'
#' @return A tibble with `id_var` as a releveled factor
#' @export
#'
#' @examples
#' patient_disposition %>%
#'   order_swimlane(subject, weeks_on_study, cohort)
order_swimlane <- function(.data, id_var, order_by, order_within = NULL) {

  id_var <- rlang::enexpr(id_var)
  order_by <- rlang::enexpr(order_by)
  order_within <- rlang::enexpr(order_within)

  # Sort without cohorts
  if(rlang::is_null(order_within)) {
    return(
      .data %>%
        dplyr::mutate(
          subject = reorder(factor(.data[[id_var]]), .data[[order_by]])
        )
    )
  }

  .data %>%
    dplyr::arrange(dplyr::desc(.data[[order_within]]), .data[[order_by]]) %>%
    dplyr::mutate(
      subject = stats::reorder(factor(.data[[id_var]]), dplyr::row_number())
    )
}
