test_that("assert_set_equal ignores order and duplicates", {
  expect_invisible(assert_set_equal(c("a", "b", "b"), c("b", "a")))
  expect_invisible(assert_set_equal(1:3, c(3, 2, 1)))
  expect_error(assert_set_equal(c("a", "b"), c("a", "c")), "same set")
})

test_that("assert_disjoint detects shared values", {
  expect_invisible(assert_disjoint(c("a", "b"), c("c", "d")))
  expect_error(assert_disjoint(c("a", "b"), c("b", "c")), "shared: b")
})

test_that("set assertion errors name the caller's second argument", {
  allowed <- c("x", "y")
  expect_error(assert_set_equal(c("a", "b"), allowed), "allowed")
  expect_error(assert_disjoint(c("a", "b"), c("b"), arg = "first"), "share no values")
})
