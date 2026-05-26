test_that("scalar type assertions pass and return input invisibly", {
  expect_invisible(assert_scalar_character("a"))
  expect_equal(assert_scalar_character("a"), "a")
  expect_invisible(assert_scalar_numeric(1))
  expect_invisible(assert_scalar_integer(1L))
  expect_invisible(assert_scalar_double(1.5))
  expect_invisible(assert_scalar_logical(TRUE))
  expect_invisible(assert_scalar_complex(1i))
})

test_that("scalar assertions reject wrong type and wrong length", {
  expect_error(assert_scalar_character(1), "single character")
  expect_error(assert_scalar_numeric("a"), "single numeric")
  expect_error(assert_scalar_integer(1.5), "single integer")
  expect_error(assert_scalar_logical(1), "single logical")
  expect_error(assert_scalar_character(c("a", "b")), "single character")
  expect_error(assert_scalar_character(character(0)), "single character")
})

test_that("scalar assertions reject NA", {
  expect_error(assert_scalar_character(NA_character_), "single character")
  expect_error(assert_scalar_numeric(NA_real_), "single numeric")
  expect_error(assert_scalar_integer(NA_integer_), "single integer")
  expect_error(assert_scalar_double(NA_real_), "single double")
  expect_error(assert_scalar_logical(NA), "single logical")
  expect_error(assert_scalar_complex(NA_complex_), "single complex")
})

test_that("vector type assertions still allow NA", {
  expect_invisible(assert_character(c("a", NA)))
  expect_invisible(assert_numeric(c(1, NA)))
  expect_invisible(assert_logical(c(TRUE, NA)))
})

test_that("vector type assertions check type at any length", {
  expect_invisible(assert_character(c("a", "b")))
  expect_invisible(assert_numeric(1:10))
  expect_invisible(assert_integer(1:10))
  expect_invisible(assert_logical(c(TRUE, FALSE)))
  expect_invisible(assert_list(list(1, "a")))
  expect_invisible(assert_factor(factor("a")))
  expect_invisible(assert_function(mean))
  expect_error(assert_character(1:3), "character vector")
  expect_error(assert_list(1:3), "be a list")
})

test_that("assert_scalar_count checks single non-negative whole numbers", {
  expect_invisible(assert_scalar_count(3))
  expect_invisible(assert_scalar_count(0L))
  expect_error(assert_scalar_count(-1), "non-negative whole number")
  expect_error(assert_scalar_count(1.5), "non-negative whole number")
  expect_error(assert_scalar_count(c(1, 2)), "non-negative whole number")
  expect_error(assert_scalar_count("a"), "non-negative whole number")
})

test_that("assert_class checks inheritance", {
  expect_invisible(assert_class(Sys.Date(), "Date"))
  expect_error(assert_class(1, "Date"), "inherit from class")
})

test_that("errors report the caller's argument name", {
  f <- function(name) assert_scalar_character(name)
  expect_error(f(1), "`name`")
})
