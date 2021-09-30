#' Swimlane charts
#'
#' A geom for swimlane plots
#'
#' @param id_var Column name for subject identifier
#' @param duration_var Column name for numeric length of time on study
#' @param cohort_var Optional column name to sort by cohort
#' @param ... Other options passed to
#'
#' @return A ggplot2 compatible geom
#' @export
#'
#' @examples
#' patient_disposition %>%
#'   dplyr::mutate(subject = reorder(factor(.data$subject), .data$weeks_on_study)) %>%
#'   ggplot2::ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort)
geom_swimlane <- function(
  id_var, duration_var, cohort_var = NULL, ...
) {

  ##FIXME: need to assert that cols exist in .data

  id_exprs <- rlang::enexpr(id_var)
  duration_exprs <- rlang::enexpr(duration_var)

  # Swimlane with no cohort
  if(rlang::quo_is_null(rlang::enquo(cohort_var))) {
    return(
      list(
        ggplot2::geom_bar(
          stat = "identity",
          ggplot2::aes(
            x = .data[[id_exprs]],
            y = .data[[duration_exprs]]
          ),
          width = .6
        ),
        ggplot2::coord_flip()
      )
    )
  }

  # Swimlane with cohort
  cohort_exprs <- rlang::enexpr(cohort_var)
  list(
    ggplot2::geom_bar(
      stat = "identity",
      ggplot2::aes(
        x = .data[[id_exprs]],
        y = .data[[duration_exprs]],
        fill = .data[[cohort_exprs]]
      ),
      width = .6
    ),
    ggplot2::coord_flip()
  )

}
