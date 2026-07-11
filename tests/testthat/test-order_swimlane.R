df_lanes <- function() {
  data.frame(
    lane = c("s1", "s2", "s3", "s4"),
    weeks = c(30, 10, 40, 20),
    arm = c("A", "A", "B", "B")
  )
}

test_that("order_swimlane relevels the passed id column, whatever its name", {
  out <- order_swimlane(df_lanes(), lane, weeks)
  expect_s3_class(out$lane, "factor")
  expect_equal(levels(out$lane), c("s2", "s4", "s1", "s3"))
  expect_false("subject" %in% setdiff(names(out), names(df_lanes())))
})

test_that("order_swimlane sorts within groups, groups descending", {
  out <- order_swimlane(df_lanes(), lane, weeks, arm)
  # arm B block first (bottom of plot), ascending duration within arm
  expect_equal(levels(out$lane), c("s4", "s3", "s2", "s1"))
})

test_that("order_swimlane validates its inputs", {
  expect_snapshot(error = TRUE, order_swimlane(df_lanes(), nope, weeks))
  expect_snapshot(error = TRUE, order_swimlane(df_lanes(), lane, arm))
})
