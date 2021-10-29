#' Swimlane charts
#'
#' A geom for swimlane plots
#'
#' @param id_var Column name for subject identifier
#' @param duration_var Column name for numeric length of time on study
#' @param cohort_var Optional column name to sort by cohort
#' @param ... Other options passed to geom_bar
#'
#' @return A ggplot2 compatible geom
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' patient_disposition %>%
#'   order_swimlane(subject, weeks_on_study, cohort) %>%
#'   ggplot() +
#'   geom_swimlane(subject, weeks_on_study, cohort) +
#'   theme_swimlane(legend.position = c(.9, .1)) +
#'   ylab("Weeks on study")
geom_swimlane <- function(
  id_var, duration_var, cohort_var = NULL, ...
) {

  ##FIXME: need to assert that cols exist in .data

  id_var <- rlang::enexpr(id_var)
  duration_var <- rlang::enexpr(duration_var)
  cohort_var <- rlang::enexpr(cohort_var)

  # Swimlane with no cohort
  if(rlang::is_null(cohort_var)) {
    return(
      list(
        ggplot2::geom_bar(
          stat = "identity",
          ggplot2::aes(
            x = .data[[id_var]],
            y = .data[[duration_var]]
          ),
          width = .6,
          ...
        ),
        ggplot2::coord_flip(clip = "off")
      )
    )
  }

  # Swimlane with cohort
  list(
    ggplot2::geom_bar(
      stat = "identity",
      ggplot2::aes(
        x = .data[[id_var]],
        y = .data[[duration_var]],
        fill = .data[[cohort_var]]
      ),
      width = .6,
      ...
    ),
    ggplot2::coord_flip(clip = "off")
  )

}

