test_that("label skips NA annotations and passes ... to the layer", {
  layers <- geom_swimlane_label(id, weeks, status, fontface = "italic")
  expect_equal(layers[[1]]$aes_params$fontface, "italic")
  p <- swim_test_plot() +
    geom_swimlane(id, weeks) +
    geom_swimlane_label(id, weeks, status)
  built <- ggplot2::ggplot_build(p)
  expect_equal(nrow(built$data[[2]]), 3)
})

test_that("labels render past the bar ends", {
  vdiffr::expect_doppelganger(
    "swimlane labels",
    swim_test_plot() +
      geom_swimlane(id, weeks, arm) +
      geom_swimlane_label(id, weeks, status) +
      theme_swimlane(extra_margin_r = 40)
  )
})
