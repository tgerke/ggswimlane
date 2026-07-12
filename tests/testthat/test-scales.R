test_that("swimlane palettes return the documented values", {
  expect_equal(swim_pal()(2), c("#0072B2", "#E69F00"))
  expect_equal(swim_pal()(8), swim_colors)
  expect_equal(swim_pal(swim_fills)(2), c("#2687BE", "#EAAD26"))
  expect_equal(swim_pal(swim_fills)(8), swim_fills)
  expect_equal(swim_shape_pal()(3), c(21, 24, 22))
  expect_equal(swim_shape_pal()(8), swim_shapes)
})

test_that("swimlane palettes warn and recycle past their length", {
  expect_warning(out <- swim_pal()(9), "recycled")
  expect_length(out, 9)
  expect_equal(out[9], swim_colors[1])
  expect_warning(out <- swim_shape_pal()(9), "recycled")
  expect_length(out, 9)
  expect_equal(out[9], swim_shapes[1])
})

test_that("scale constructors return ggplot2 scales for the right aesthetics", {
  expect_s3_class(scale_fill_swimlane(), "Scale")
  expect_s3_class(scale_colour_swimlane(), "Scale")
  expect_s3_class(scale_shape_swimlane(), "Scale")
  expect_setequal(scale_fill_swimlane()$aesthetics, "fill")
  expect_setequal(scale_colour_swimlane()$aesthetics, "colour")
  expect_setequal(scale_shape_swimlane()$aesthetics, "shape")
})

test_that("scale_shape_swimlane maps named values by level", {
  df <- data.frame(x = 1:2, y = c("s1", "s2"), status = c("Alpha", "Beta"))
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, shape = status)) +
    ggplot2::geom_point() +
    scale_shape_swimlane(values = c("Beta" = 0, "Alpha" = 16))
  expect_equal(ggplot2::layer_data(p)$shape, c(16, 0))
})

test_that("scale_shape_swimlane errors when unnamed values run short", {
  df <- data.frame(x = 1:3, y = c("s1", "s2", "s3"))
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, shape = y)) +
    ggplot2::geom_point() +
    scale_shape_swimlane(values = c(16, 17))
  expect_snapshot(error = TRUE, ggplot2::ggplot_build(p))
})
