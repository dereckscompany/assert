test_that("data frame and data table type checks work", {
  df <- data.frame(a = 1:3, b = 4:6)
  expect_invisible(assert_data_frame(df))
  expect_error(assert_data_frame(1:3), "data frame")

  dt <- df
  class(dt) <- c("data.table", "data.frame")
  expect_invisible(assert_data_table(dt))
  expect_error(assert_data_table(df), "data table")
})

test_that("emptiness and dimension checks work", {
  df <- data.frame(a = 1:3, b = 4:6)
  expect_invisible(assert_not_empty_data_frame(df))
  expect_error(assert_not_empty_data_frame(data.frame()), "at least one row")
  expect_invisible(assert_number_of_rows(df, 3))
  expect_error(assert_number_of_rows(df, 2), "2 rows")
  expect_invisible(assert_number_of_columns(df, 2))
  expect_error(assert_number_of_columns(df, 3), "3 columns")
})

test_that("column presence and naming checks work", {
  df <- data.frame(a = 1, b = 2, c = 3)
  expect_invisible(assert_has_columns(df, c("a", "b")))
  expect_error(assert_has_columns(df, c("a", "z")), "z")
  expect_invisible(assert_column_names(df, c("c", "b", "a")))
  expect_error(assert_column_names(df, c("a", "b")), "exactly these columns")
  expect_invisible(assert_column_names(df, c("a", "b", "c"), ordered = TRUE))
  expect_error(assert_column_names(df, c("c", "b", "a"), ordered = TRUE), "in order")
})

test_that("missing-in-columns and unique-rows checks work", {
  df <- data.frame(a = c(1, 2, NA), b = c(4, 5, 6))
  expect_invisible(assert_no_missing_in_columns(df, "b"))
  expect_error(assert_no_missing_in_columns(df, "a"), "missing values in columns")
  expect_error(assert_no_missing_in_columns(df), "missing values in columns")

  expect_invisible(assert_unique_rows(data.frame(a = c(1, 2), b = c(3, 4))))
  expect_error(assert_unique_rows(data.frame(a = c(1, 1), b = c(3, 3))), "duplicate rows")
})

test_that("assert_column_types checks each column's type", {
  people <- data.frame(name = "Ada", age = 36L, stringsAsFactors = FALSE)
  expect_invisible(assert_column_types(people, list(name = "character", age = "integer")))
  expect_error(
    assert_column_types(people, list(age = "character")),
    "expected character"
  )
  expect_error(assert_column_types(people, list(missing = "integer")), "missing")
  expect_error(assert_column_types(people, list("character")), "must be named")
})

test_that("assert_column_types falls back to inherits for arbitrary classes", {
  events <- data.frame(when = Sys.Date(), label = "x", stringsAsFactors = FALSE)
  expect_invisible(assert_column_types(events, list(when = "Date")))
  expect_error(assert_column_types(events, list(label = "Date")), "expected Date")
})

test_that("assert_columns_are_type checks a shared type", {
  measurements <- data.frame(height = 1.8, weight = 75.0, label = "a", stringsAsFactors = FALSE)
  expect_invisible(assert_columns_are_type(measurements, c("height", "weight"), "numeric"))
  expect_error(
    assert_columns_are_type(measurements, c("height", "label"), "numeric"),
    "label"
  )
  expect_error(assert_columns_are_type(measurements, "missing", "numeric"), "missing")
})
