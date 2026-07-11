# Extract a column name from a quosure when it is a simple symbol or string.
# Complex expressions return character(0) and are left for ggplot2's own tidy
# evaluation to resolve.
quo_col_name <- function(quo) {
  if (rlang::quo_is_symbol(quo)) {
    return(rlang::as_name(quo))
  }
  expr <- rlang::quo_get_expr(quo)
  if (rlang::is_string(expr)) {
    return(expr)
  }
  character(0)
}

check_swimlane_cols <- function(data, cols, fn) {
  missing_cols <- setdiff(cols, names(data))
  if (length(missing_cols) > 0) {
    cli::cli_abort(
      "{cli::qty(missing_cols)}Column{?s} {.field {missing_cols}} not found
       in the data supplied to {.fn {fn}}.",
      call = NULL
    )
  }
  invisible(data)
}

# Build a layer data function that validates required columns at plot-build
# time, then applies a transformation to the plot data.
swim_layer_data <- function(quos, fn, transform = identity) {
  cols <- unlist(lapply(quos, quo_col_name))
  function(data) {
    check_swimlane_cols(data, cols, fn)
    transform(data)
  }
}

# Transform that drops rows where the quosure evaluates to NA, so annotation
# layers skip subjects without the event instead of warning.
swim_drop_na <- function(quo) {
  function(data) {
    data[!is.na(rlang::eval_tidy(quo, data)), , drop = FALSE]
  }
}
