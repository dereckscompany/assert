test_that("comparison assertions work against a scalar threshold", {
  expect_invisible(assert_all_greater_than(c(2, 3, 4), 1))
  expect_error(assert_all_greater_than(c(2, 1), 1), "greater than 1")
  expect_invisible(assert_all_greater_than_or_equal(c(1, 2), 1))
  expect_error(assert_all_greater_than_or_equal(c(0, 1), 1), "greater than or equal")
  expect_invisible(assert_all_less_than(c(1, 2), 3))
  expect_error(assert_all_less_than(c(1, 3), 3), "less than 3")
  expect_invisible(assert_all_less_than_or_equal(c(1, 3), 3))
  expect_error(assert_all_less_than_or_equal(c(1, 4), 3), "less than or equal")
})

test_that("comparison assertions work element-wise and reject NA", {
  expect_invisible(assert_all_less_than_or_equal(c(1, 2), c(1, 5)))
  expect_error(assert_all_less_than_or_equal(c(2, 2), c(1, 5)), "less than or equal")
  expect_error(assert_all_greater_than(c(1, NA), 0), "greater than")
})

test_that("assert_sorted handles direction and strictness", {
  expect_invisible(assert_sorted(c(1, 2, 2, 3)))
  expect_error(assert_sorted(c(1, 3, 2)), "ascending")
  expect_invisible(assert_sorted(c(3, 2, 1), decreasing = TRUE))
  expect_error(assert_sorted(c(1, 2, 3), decreasing = TRUE), "descending")
  expect_invisible(assert_sorted(c(1, 2, 3), strictly = TRUE))
  expect_error(assert_sorted(c(1, 2, 2), strictly = TRUE), "strictly ascending")
})

test_that("assert_sorted works on non-numeric orderable types", {
  expect_invisible(assert_sorted(c("a", "b", "c")))
  expect_error(assert_sorted(c("a", "c", "b")), "ascending")
  expect_invisible(assert_sorted(c("c", "b", "a"), decreasing = TRUE))
  expect_invisible(assert_sorted(as.Date(c("2020-01-01", "2020-02-01"))))
  expect_error(assert_sorted(as.Date(c("2020-02-01", "2020-01-01"))), "ascending")
})

test_that("assert_same_length compares lengths", {
  expect_invisible(assert_same_length(c(1, 2, 3), c("a", "b", "c")))
  expect_error(assert_same_length(1:3, 1:2), "same length")
  expect_error(assert_same_length(1:3), "at least two")
})
