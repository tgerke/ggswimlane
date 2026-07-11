test_that("geom_swimlane returns bar layer, scales, and unclipped coord", {
  bare <- geom_swimlane(id, weeks)
  filled <- geom_swimlane(id, weeks, arm)
  is_scale <- function(x) inherits(x, "Scale")
  expect_length(Filter(is_scale, bare), 1) # shape only
  expect_length(Filter(is_scale, filled), 2) # shape + fill
  coord <- Filter(function(x) inherits(x, "CoordCartesian"), filled)[[1]]
  expect_false(coord$clip == "on")
})

test_that("geom_swimlane errors informatively on missing columns", {
  p <- swim_test_plot() + geom_swimlane(id, not_a_column)
  expect_snapshot(error = TRUE, ggplot2::ggplot_build(p))
})

test_that("swimlane bars render", {
  vdiffr::expect_doppelganger(
    "swimlane bare",
    swim_test_plot() + geom_swimlane(id, weeks) + theme_swimlane()
  )
  vdiffr::expect_doppelganger(
    "swimlane cohort fill",
    swim_test_plot() + geom_swimlane(id, weeks, arm) + theme_swimlane()
  )
})

test_that("swimlane bars stack segments in long data", {
  df_long <- data.frame(
    id = rep(c("s1", "s2"), each = 2),
    phase = rep(c("Treatment", "Follow-up"), 2),
    weeks = c(10, 5, 20, 8)
  )
  df_long$phase <- factor(df_long$phase, levels = c("Treatment", "Follow-up"))
  vdiffr::expect_doppelganger(
    "swimlane stacked phases",
    ggplot2::ggplot(df_long) +
      geom_swimlane(id, weeks, phase) +
      theme_swimlane()
  )
})
