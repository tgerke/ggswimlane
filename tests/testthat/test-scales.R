test_that("swimlane palettes return the documented values", {
  expect_equal(swim_pal()(2), c("#0072B2", "#E69F00"))
  expect_equal(swim_pal()(8), swim_colors)
  expect_equal(swim_shape_pal()(3), c(16, 17, 15))
  expect_equal(swim_shape_pal()(7), swim_shapes)
})

test_that("swimlane palettes warn and recycle past their length", {
  expect_warning(out <- swim_pal()(9), "recycled")
  expect_length(out, 9)
  expect_equal(out[9], swim_colors[1])
  expect_warning(out <- swim_shape_pal()(8), "recycled")
  expect_length(out, 8)
  expect_equal(out[8], swim_shapes[1])
})

test_that("scale constructors return ggplot2 scales for the right aesthetics", {
  expect_s3_class(scale_fill_swimlane(), "Scale")
  expect_s3_class(scale_colour_swimlane(), "Scale")
  expect_s3_class(scale_shape_swimlane(), "Scale")
  expect_setequal(scale_fill_swimlane()$aesthetics, "fill")
  expect_setequal(scale_colour_swimlane()$aesthetics, "colour")
  expect_setequal(scale_shape_swimlane()$aesthetics, "shape")
})
