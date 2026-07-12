test_that("rug skips subjects without the flag", {
  p <- swim_test_plot() +
    geom_swimlane(id, weeks) +
    geom_swimlane_rug(id, baseline)
  built <- ggplot2::ggplot_build(p)
  # layer 2: halo; layer 3: rug points
  expect_equal(nrow(built$data[[3]]), 2)
})

test_that("rug renders in the left margin with a legend entry", {
  vdiffr::expect_doppelganger(
    "swimlane rug",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_rug(id, baseline) +
      theme_swimlane()
  )
})
