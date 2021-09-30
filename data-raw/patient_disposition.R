# Number of patients to simulate
n <- 20

# Simulate a disposition table
set.seed(8675309)

patient_disposition <- dplyr::tibble(
  subject = sample(111111:999999, n, replace = FALSE) %>%
    as.character(),
  weeks_on_study = runif(n, min = 0, max = 100),
  cohort = sample(c("Cohort A", "Cohort B"), n, replace = TRUE),
  # For patients who have been on study for sufficient time,
  # assign either Active (indicated by NA) or Completed; others
  # are assigned standard early stopping phrases
  reason_off_study = case_when(
    weeks_on_study < 75 ~ sample(
      c(
        "Adverse event", "Withdrawal by subject",
        "Physician decision", "Disease progression"
      ),
      n, replace = TRUE
    ),
    weeks_on_study >= 75 ~ sample(
      c("Completed", NA_character_), n, replace = TRUE
    )
  ),
  # Create a baseline characteristic
  prior_drug = sample(c("Yes", "No"), n, replace = TRUE)
) %>%
  # Create an indicator for partial response for some patients
  group_by(subject) %>%
  mutate(
    partial_response = sample(
      c(runif(1, min = 0, max = weeks_on_study), NA_real_),
      size = 1
    )
  ) %>%
  ungroup()

usethis::use_data(patient_disposition, overwrite = TRUE)
