test_that("assert_range checks lower <= upper across types", {
  expect_invisible(assert_range(0, 10))
  expect_invisible(assert_range(5, 5))
  expect_error(assert_range(10, 0), "less than or equal")
  expect_invisible(assert_range(as.Date("2026-01-01"), as.Date("2026-12-31")))
  expect_error(assert_range(as.Date("2026-12-31"), as.Date("2026-01-01")), "less than or equal")
  expect_invisible(assert_range(
    as.POSIXct("2026-01-01 09:00", tz = "UTC"),
    as.POSIXct("2026-01-01 17:00", tz = "UTC")
  ))
})

test_that("assert_range treats NULL bounds as open-ended", {
  expect_invisible(assert_range(NULL, 10))
  expect_invisible(assert_range(0, NULL))
  expect_invisible(assert_range(NULL, NULL))
})

test_that("assert_range names the offending arguments", {
  f <- function(start, end) assert_range(start, end)
  expect_error(f(10, 0), "start")
})

test_that("assert_between checks inclusive bounds across types", {
  expect_invisible(assert_between(5, 0, 10))
  expect_invisible(assert_between(c(0, 5, 10), 0, 10))
  expect_error(assert_between(11, 0, 10), "at most 10")
  expect_error(assert_between(-1, 0, 10), "at least 0")
  expect_invisible(assert_between(
    as.POSIXct("2026-01-01 12:00", tz = "UTC"),
    as.POSIXct("2026-01-01 09:00", tz = "UTC"),
    as.POSIXct("2026-01-01 17:00", tz = "UTC")
  ))
})

test_that("assert_between supports open bounds and rejects NA", {
  expect_invisible(assert_between(100, lower = 0))
  expect_invisible(assert_between(-100, upper = 0))
  expect_error(assert_between(5), "at least one")
  expect_error(assert_between(c(1, NA), 0, 10), "missing values")
  expect_invisible(assert_between(NULL, 0, 10, null_ok = TRUE))
})

test_that("assert_between honours inclusive/exclusive bounds independently", {
  # ]0, 1] : lower exclusive, upper inclusive
  expect_invisible(assert_between(c(0.5, 1), 0, 1, lower_inclusive = FALSE))
  expect_error(assert_between(0, 0, 1, lower_inclusive = FALSE), "greater than 0")
  # [0, 1[ : lower inclusive, upper exclusive
  expect_invisible(assert_between(c(0, 0.5), 0, 1, upper_inclusive = FALSE))
  expect_error(assert_between(1, 0, 1, upper_inclusive = FALSE), "less than 1")
  # ]0, 1[ : both exclusive
  expect_invisible(assert_between(0.5, 0, 1, lower_inclusive = FALSE, upper_inclusive = FALSE))
  expect_error(assert_between(1, 0, 1, lower_inclusive = FALSE, upper_inclusive = FALSE), "less than 1")
})

test_that("assert_between exclusive bounds work on Date/POSIXct (class-agnostic, no is.numeric gate)", {
  expect_invisible(assert_between(
    as.Date("2024-06-01"),
    as.Date("2024-01-01"),
    as.Date("2024-12-31"),
    lower_inclusive = FALSE,
    upper_inclusive = FALSE
  ))
  expect_error(
    assert_between(as.Date("2024-01-01"), as.Date("2024-01-01"), lower_inclusive = FALSE),
    "greater than"
  )
  # one-sided open upper on a date-time
  expect_invisible(assert_between(
    as.POSIXct("2024-06-01", tz = "UTC"),
    upper = as.POSIXct("2025-01-01", tz = "UTC"),
    upper_inclusive = FALSE
  ))
})

test_that("assert_between na_ok ignores NA elements", {
  expect_invisible(assert_between(c(1, NA, 3), 0, 10, na_ok = TRUE))
  expect_error(assert_between(c(1, NA, 30), 0, 10, na_ok = TRUE), "at most 10")
  expect_invisible(assert_between(NA_real_, 0, 10, na_ok = TRUE))
})
