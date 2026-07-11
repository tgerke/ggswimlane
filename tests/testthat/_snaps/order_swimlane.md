# order_swimlane validates its inputs

    Code
      order_swimlane(df_lanes(), nope, weeks)
    Condition
      Error:
      ! Column nope not found in the data supplied to `order_swimlane()`.

---

    Code
      order_swimlane(df_lanes(), lane, arm)
    Condition
      Error:
      ! `order_by` must be a numeric column.

