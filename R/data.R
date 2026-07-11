#' A simulated patient disposition table
#'
#' A dataset describing assigned cohort, time on study, and key
#' patient characteristics for 20 simulated trial participants.
#'
#' @format A data frame with 20 rows and 7 variables:
#' \describe{
#'   \item{subject}{subject identifier}
#'   \item{weeks_on_study}{weeks on study, as a dbl}
#'   \item{cohort}{study cohort}
#'   \item{reason_off_study}{a string describing reason for study exit;
#'     `NA` for subjects still on study}
#'   \item{prior_drug}{an indicator for receipt of therapy prior to trial}
#'   \item{partial_response}{timing of response with units as weeks_on_study;
#'     `NA` for subjects without a response}
#'   \item{weeks_on_treatment}{weeks in the active treatment phase; the
#'     remainder of weeks_on_study is follow-up}
#' }
"patient_disposition"
