# check_swimlane_cols errors informatively on missing columns

    Code
      check_swimlane_cols(df, c("a", "b", "c"), "geom_swimlane")
    Condition
      Error:
      ! Columns b and c not found in the data supplied to `geom_swimlane()`.

