test_that("assert_date checks the Date class", {
  expect_invisible(assert_date(Sys.Date()))
  expect_invisible(assert_date(as.Date(c("2026-01-01", "2026-02-01"))))
  expect_error(assert_date(Sys.time()), "be a date")
  expect_error(assert_date("2026-01-01"), "be a date")
  expect_invisible(assert_date(NULL, null_ok = TRUE))
})

test_that("assert_datetime checks the POSIXct class", {
  expect_invisible(assert_datetime(Sys.time()))
  expect_error(assert_datetime(Sys.Date()), "be a date-time")
  expect_error(assert_datetime("2026-01-01 00:00"), "be a date-time")
  expect_invisible(assert_datetime(NULL, null_ok = TRUE))
})

test_that("scalar date/datetime require length 1 and reject NA", {
  expect_invisible(assert_scalar_date(Sys.Date()))
  expect_error(assert_scalar_date(as.Date(c("2026-01-01", "2026-02-01"))), "single date")
  expect_error(assert_scalar_date(as.Date(NA)), "single date")

  expect_invisible(assert_scalar_datetime(Sys.time()))
  expect_error(assert_scalar_datetime(as.POSIXct(c("2026-01-01", "2026-01-02"), tz = "UTC")), "single date-time")
  expect_error(assert_scalar_datetime(as.POSIXct(NA, tz = "UTC")), "single date-time")
})

test_that("lubridate-style POSIXct passes assert_datetime", {
  x <- as.POSIXct("2026-01-01 12:00:00", tz = "UTC")
  expect_invisible(assert_datetime(x))
  expect_invisible(assert_scalar_datetime(x))
})
