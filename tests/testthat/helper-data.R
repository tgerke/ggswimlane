# Small deterministic disposition table used across geom tests
swim_test_data <- function() {
  data.frame(
    id = c("s1", "s2", "s3", "s4"),
    weeks = c(30, 10, 40, 20),
    arm = c("A", "A", "B", "B"),
    status = c("Progression", NA, "Completed", "Adverse event"),
    response = c(12, NA, 25, NA),
    baseline = c("Prior therapy", NA, "Prior therapy", NA)
  )
}

swim_test_plot <- function() {
  ggplot2::ggplot(order_swimlane(swim_test_data(), id, weeks, arm))
}
