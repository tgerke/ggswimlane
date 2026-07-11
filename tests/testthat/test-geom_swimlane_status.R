test_that("NA statuses are recoded to the ongoing label", {
  p <- swim_test_plot() +
    geom_swimlane(id, weeks, arm) +
    geom_swimlane_status(id, weeks, status)
  built <- ggplot2::ggplot_build(p)
  # layer 2: off-study points; layer 3: ongoing arrows
  expect_equal(nrow(built$data[[2]]), 3)
  expect_equal(nrow(built$data[[3]]), 1)
})

test_that("arrow = FALSE folds ongoing into the shape legend", {
  layers <- geom_swimlane_status(id, weeks, status, arrow = FALSE)
  expect_length(layers, 1)
  p <- swim_test_plot() +
    geom_swimlane(id, weeks, arm) +
    geom_swimlane_status(id, weeks, status, arrow = FALSE)
  built <- ggplot2::ggplot_build(p)
  expect_equal(nrow(built$data[[2]]), 4)
})

test_that("status points render with arrow legend", {
  vdiffr::expect_doppelganger(
    "swimlane status arrow",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_status(id, weeks, status) +
      theme_swimlane()
  )
  vdiffr::expect_doppelganger(
    "swimlane status no arrow",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_status(id, weeks, status, arrow = FALSE) +
      theme_swimlane()
  )
})

test_that("status errors informatively on missing columns", {
  p <- swim_test_plot() +
    geom_swimlane(id, weeks) +
    geom_swimlane_status(id, weeks, not_a_column)
  expect_snapshot(error = TRUE, ggplot2::ggplot_build(p))
})
