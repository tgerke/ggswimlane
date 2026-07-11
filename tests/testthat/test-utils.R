test_that("quo_col_name extracts symbol and string columns", {
  expect_equal(quo_col_name(rlang::quo(subject)), "subject")
  expect_equal(quo_col_name(rlang::quo("subject")), "subject")
  expect_length(quo_col_name(rlang::quo(factor(subject))), 0)
})

test_that("check_swimlane_cols errors informatively on missing columns", {
  df <- data.frame(a = 1)
  expect_invisible(check_swimlane_cols(df, "a", "geom_swimlane"))
  expect_snapshot(
    error = TRUE,
    check_swimlane_cols(df, c("a", "b", "c"), "geom_swimlane")
  )
})

test_that("swim_drop_na removes rows where the quosure is NA", {
  df <- data.frame(x = c(1, NA, 3), y = c("a", "b", NA))
  drop_x <- swim_drop_na(rlang::quo(x))
  expect_equal(drop_x(df)$x, c(1, 3))
  drop_y <- swim_drop_na(rlang::quo(y))
  expect_equal(drop_y(df)$y, c("a", "b"))
})
