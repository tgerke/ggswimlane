% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_swimlane_text.R
\name{geom_swimlane_text}
\alias{geom_swimlane_text}
\title{Add text to the end of each swimlane bar}
\usage{
geom_swimlane_text(x, y, label, ...)
}
\arguments{
\item{x}{Typically subject identifier}

\item{y}{Typically duration on study}

\item{label}{Annotation text}

\item{...}{Other options passed to ggtext::geom_richtext}
}
\description{
Most often used to annotate each bar with reason for ending study
or, if applicable, active status.
}
\examples{
library(ggplot2)

patient_disposition \%>\%
  dplyr::mutate(
    reason_off_study = tidyr::replace_na(reason_off_study, "&#8594;")
  ) \%>\%
  order_swimlane(subject, weeks_on_study, cohort) \%>\%
  ggplot() +
  geom_swimlane(subject, weeks_on_study, cohort) +
  ggsci::scale_fill_jco() +
  geom_swimlane_text(subject, weeks_on_study, reason_off_study) +
  theme_swimlane(legend.position = c(.9, .1)) \%+replace\%
  theme(axis.title.x = element_blank())
}
