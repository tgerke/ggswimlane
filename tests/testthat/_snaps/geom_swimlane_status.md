# status errors informatively on missing columns

    Code
      ggplot2::ggplot_build(p)
    Condition
      Error in `ggplot2::geom_point()`:
      ! Problem while computing layer data.
      i Error occurred in the 2nd layer.
      Caused by error:
      ! Column not_a_column not found in the data supplied to `geom_swimlane_status()`.

