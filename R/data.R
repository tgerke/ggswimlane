#' A simulated patient disposition table
#'
#' A dataset describing assigned cohort, time on study, and key
#' patient characteristics for 20 simulated trial participants.
#'
#' @format A data frame with 20 rows and 6 variables:
#' \describe{
#'   \item{subject}{subject identifier}
#'   \item{weeks_on_study}{weeks on study, as a dbl}
#'   \item{cohort}{study cohort}
#'   \item{reason_off_study}{a string describing reasons for study exit}
#'   \item{prior_drug}{an indicator for receipt of therapy prior to trial}
#'   \item{partial_response}{timing of response with units as weeks_on_study}
#' }
"patient_disposition"
