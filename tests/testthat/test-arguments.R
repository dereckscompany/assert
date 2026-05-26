test_that("assert_mutually_exclusive allows zero or one supplied", {
  f <- function(a = NULL, b = NULL) {
    assert_mutually_exclusive(a, b)
    return("ok")
  }
  expect_equal(f(), "ok")
  expect_equal(f(a = 1), "ok")
  expect_equal(f(b = 2), "ok")
  expect_error(f(a = 1, b = 2), "Only one")
})

test_that("assert_mutually_exclusive names the offending arguments", {
  f <- function(colour = NULL, palette = NULL) {
    return(assert_mutually_exclusive(colour, palette))
  }
  expect_error(f(colour = "red", palette = "warm"), "colour")
})

test_that("assert_at_least_one requires a non-NULL", {
  f <- function(id = NULL, name = NULL) {
    assert_at_least_one(id, name)
    return("ok")
  }
  expect_equal(f(id = 1), "ok")
  expect_equal(f(name = "x"), "ok")
  expect_error(f(), "At least one")
})

test_that("assert_exactly_one requires precisely one", {
  f <- function(url = NULL, socket = NULL) {
    assert_exactly_one(url, socket)
    return("ok")
  }
  expect_equal(f(url = "localhost"), "ok")
  expect_error(f(), "Exactly one")
  expect_error(f(url = "a", socket = "b"), "Exactly one")
})
