test_that("assert_minimum_characters checks lower bound", {
  expect_invisible(assert_minimum_characters(c("abc", "abcd"), 3))
  expect_error(assert_minimum_characters(c("abc", "ab"), 3), "at least 3")
  expect_error(assert_minimum_characters(c("abc", NA), 3), "at least 3")
  expect_error(assert_minimum_characters(1:3, 3), "at least 3")
})

test_that("assert_maximum_characters checks upper bound", {
  expect_invisible(assert_maximum_characters(c("abc", "ab"), 3))
  expect_error(assert_maximum_characters(c("abc", "abcd"), 3), "at most 3")
})
