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

test_that("assert_column_types checks a set of columns share one type", {
  people <- data.frame(name = "Ada", height = 1.8, weight = 75.0, stringsAsFactors = FALSE)
  expect_invisible(assert_column_types(people, "numeric", c("height", "weight")))
  expect_error(
    assert_column_types(people, "numeric", c("height", "name")),
    "name"
  )
  expect_error(assert_column_types(people, "numeric", "missing"), "missing")
})

test_that("assert_column_types falls back to inherits for arbitrary classes", {
  events <- data.frame(when = Sys.Date(), label = "x", stringsAsFactors = FALSE)
  expect_invisible(assert_column_types(events, "Date", "when"))
  expect_error(assert_column_types(events, "Date", "label"), "type Date")
})

test_that("data-frame column checks work on a real data.table", {
  skip_if_not_installed("data.table")
  dt <- data.table::data.table(symbol = "BTC/USDT", price = 50000, qty = 1L, ts = Sys.time())
  expect_invisible(assert_has_columns(dt, c("symbol", "price")))
  expect_invisible(assert_column_types(dt, "numeric", "price"))
  expect_error(assert_column_types(dt, "numeric", c("price", "symbol")), "symbol")
  expect_invisible(assert_no_missing_in_columns(dt, c("symbol", "price")))
  expect_invisible(assert_unique_rows(dt))

  dt_na <- data.table::data.table(a = c(1, NA), b = c("x", "y"))
  expect_error(assert_no_missing_in_columns(dt_na, "a"), "missing")
})
