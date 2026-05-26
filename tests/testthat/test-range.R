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
