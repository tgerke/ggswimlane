% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{patient_disposition}
\alias{patient_disposition}
\title{A simulated patient disposition table}
\format{
A data frame with 20 rows and 6 variables:
\describe{
\item{subject}{subject identifier}
\item{weeks_on_study}{weeks on study, as a dbl}
\item{cohort}{study cohort}
\item{reason_off_study}{a string describing reasons for study exit}
\item{prior_drug}{an indicator for receipt of therapy prior to trial}
\item{partial_response}{timing of response with units as weeks_on_study}
}
}
\usage{
patient_disposition
}
\description{
A dataset describing assigned cohort, time on study, and key
patient characteristics for 20 simulated trial participants.
}
\keyword{datasets}
