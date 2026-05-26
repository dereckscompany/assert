test_that("length assertions work", {
  expect_invisible(assert_length(1:3, 3))
  expect_error(assert_length(1:3, 2), "length 2")
  expect_invisible(assert_minimum_length(1:5, 3))
  expect_error(assert_minimum_length(1:2, 3), "at least 3")
  expect_invisible(assert_maximum_length(1:5, 10))
  expect_error(assert_maximum_length(1:5, 3), "at most 3")
  expect_invisible(assert_not_empty(1))
  expect_error(assert_not_empty(integer(0)), "not be empty")
})

test_that("name assertions work", {
  expect_invisible(assert_named(c(a = 1, b = 2)))
  expect_error(assert_named(c(1, 2)), "have names")
  expect_error(assert_named(stats::setNames(1:2, c("a", ""))), "have names")
  expect_invisible(assert_unique_names(c(a = 1, b = 2)))
  expect_error(assert_unique_names(stats::setNames(1:2, c("a", "a"))), "unique names")
})

test_that("assert_has_names checks for required names", {
  config <- list(host = "localhost", port = 8080, timeout = 30)
  expect_invisible(assert_has_names(config, c("host", "port")))
  expect_error(assert_has_names(config, c("host", "missing")), "missing")
  expect_invisible(assert_has_names(c(a = 1, b = 2), "a"))
})
