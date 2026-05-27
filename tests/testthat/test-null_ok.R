test_that("null_ok = TRUE lets NULL pass across assertion families", {
  expect_invisible(assert_scalar_character(NULL, null_ok = TRUE))
  expect_invisible(assert_numeric(NULL, null_ok = TRUE))
  expect_invisible(assert_length(NULL, 3, null_ok = TRUE))
  expect_invisible(assert_all_positive(NULL, null_ok = TRUE))
  expect_invisible(assert_data_frame(NULL, null_ok = TRUE))
  expect_invisible(assert_has_columns(NULL, "a", null_ok = TRUE))
  expect_invisible(assert_all_greater_than(NULL, 0, null_ok = TRUE))
})

test_that("null_ok defaults to FALSE so NULL is rejected", {
  expect_error(assert_scalar_character(NULL), "single character")
  expect_error(assert_numeric(NULL), "numeric vector")
  expect_error(assert_data_frame(NULL), "data frame")
  expect_error(assert_all_positive(NULL), "positive")
})

test_that("null_ok = TRUE still checks non-NULL values", {
  expect_error(assert_scalar_character(1, null_ok = TRUE), "single character")
  expect_error(assert_data_frame(1, null_ok = TRUE), "data frame")
  # a list of NULLs is not NULL and must still satisfy the type check
  expect_error(assert_scalar_numeric(list(NULL), null_ok = TRUE), "single numeric")
})
