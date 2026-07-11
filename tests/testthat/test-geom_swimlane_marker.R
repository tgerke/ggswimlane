test_that("marker skips subjects without the event", {
  p <- swim_test_plot() +
    geom_swimlane(id, weeks) +
    geom_swimlane_marker(id, response)
  built <- ggplot2::ggplot_build(p)
  expect_equal(nrow(built$data[[2]]), 2)
})

test_that("marker_var and marker_label are mutually exclusive", {
  expect_snapshot(
    error = TRUE,
    geom_swimlane_marker(id, response, marker_var = arm, marker_label = "PR")
  )
})

test_that("markers render with and without a legend entry", {
  vdiffr::expect_doppelganger(
    "swimlane marker label",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_marker(id, response, marker_label = "Partial response") +
      theme_swimlane()
  )
  vdiffr::expect_doppelganger(
    "swimlane marker plain",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_marker(id, response) +
      theme_swimlane()
  )
})
