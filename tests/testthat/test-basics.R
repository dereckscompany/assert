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

test_that("assert_any_of accepts when any alternative passes", {
  expect_invisible(assert_any_of(42, assert_numeric, assert_character))
  expect_invisible(assert_any_of("a", assert_numeric, assert_character))
  expect_invisible(assert_any_of(NULL, assert_numeric, null_ok = TRUE))
})

test_that("assert_any_of fails when every alternative fails, listing each reason", {
  err <- expect_error(
    assert_any_of(TRUE, assert_numeric, assert_character),
    "at least one of"
  )
  # the combined message surfaces both alternatives' requirements
  expect_match(conditionMessage(err), "numeric")
  expect_match(conditionMessage(err), "character")
})

test_that("assert_any_of supports constrained alternatives (closures stacking checks)", {
  d6 <- function(x) {
    assert_scalar_integer(x)
    assert_between(x, 1L, 6L)
  }
  expect_invisible(assert_any_of(3L, d6, function(v) assert_scalar_character(v)))
  expect_invisible(assert_any_of("d6", d6, function(v) assert_scalar_character(v)))
  expect_error(assert_any_of(7L, d6, function(v) assert_scalar_character(v)), "at least one of")
})

test_that("assert_any_of requires at least one check", {
  expect_error(assert_any_of(1), "at least one assertion")
})
