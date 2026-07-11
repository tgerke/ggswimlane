test_that("theme_swimlane returns a complete theme with swimlane defaults", {
  thm <- theme_swimlane()
  expect_s3_class(thm, "theme")
  expect_equal(thm$legend.position, "bottom")
  expect_s3_class(thm$axis.title.y, "element_blank")
  expect_s3_class(thm$panel.grid.major.y, "element_blank")
})

test_that("extra_margin_r widens the right plot margin", {
  narrow <- theme_swimlane(extra_margin_r = 0)
  wide <- theme_swimlane(extra_margin_r = 40)
  expect_equal(
    as.numeric(wide$plot.margin[2]) - as.numeric(narrow$plot.margin[2]),
    40
  )
})

test_that("theme arguments pass through ...", {
  thm <- theme_swimlane(legend.position = "right")
  expect_equal(thm$legend.position, "right")
})
