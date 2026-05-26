test_that("assert_true accepts only a single TRUE", {
  expect_invisible(assert_true(1 > 0))
  expect_error(assert_true(1 < 0), "be TRUE")
  expect_error(assert_true(NA), "be TRUE")
  expect_error(assert_true(c(TRUE, TRUE)), "be TRUE")
  expect_error(assert_true(1 < 0, message = "x must be odd."), "must be odd")
})

test_that("assert_false accepts only a single FALSE", {
  expect_invisible(assert_false(1 < 0))
  expect_error(assert_false(1 > 0), "be FALSE")
  expect_error(assert_false(NA), "be FALSE")
})

test_that("assert_null and assert_not_null work", {
  expect_invisible(assert_null(NULL))
  expect_error(assert_null(1), "be NULL")
  expect_invisible(assert_not_null(1))
  expect_error(assert_not_null(NULL), "not be NULL")
})

test_that("assert_list_of checks element types", {
  expect_invisible(assert_list_of(list("a", "b"), "character"))
  expect_invisible(assert_list_of(list(1, 2, 3), "numeric"))
  expect_invisible(assert_list_of(list(Sys.Date()), "Date"))
  expect_error(assert_list_of(list("a", 1), "character"), "type character")
  expect_error(assert_list_of(1:3, "numeric"), "be a list")
  expect_invisible(assert_list_of(NULL, "character", null_ok = TRUE))
})
