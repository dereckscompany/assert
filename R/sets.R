# Set assertions compare the values of two objects as sets (ignoring order and
# duplicates). For "x is a subset of allowed values" see assert_values_in_set().

#' Assert that two objects hold the same set of values
#'
#' Checks that `x` and `y` contain the same values, ignoring order and
#' duplicates (using [setequal()]).
#'
#' @inheritParams scalar-assertions
#' @param y The object whose values `x` must match as a set.
#' @param arg_y Name used to refer to `y` in error messages. Defaults to the
#'   name of the expression passed as `y`.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_set_equal(c("a", "b", "b"), c("b", "a"))
#'
#' @export
assert_set_equal <- function(
  x,
  y,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  arg_y = rlang::caller_arg(y),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!setequal(x, y)) {
    abort_assertion(arg, "contain the same set of values as {.arg {arg_y}}", call)
  }
  return(invisible(x))
}

#' Assert that two objects share no values
#'
#' Checks that `x` and `y` have no values in common (their intersection is
#' empty).
#'
#' @inheritParams scalar-assertions
#' @param y The object that `x` must not overlap with.
#' @param arg_y Name used to refer to `y` in error messages. Defaults to the
#'   name of the expression passed as `y`.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_disjoint(c("a", "b"), c("c", "d"))
#'
#' @export
assert_disjoint <- function(
  x,
  y,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  arg_y = rlang::caller_arg(y),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  shared <- intersect(x, y)
  if (length(shared) > 0L) {
    formatted <- paste(shared, collapse = ", ")
    abort_assertion(arg, paste0("share no values with {.arg {arg_y}}, but these are shared: ", formatted), call)
  }
  return(invisible(x))
}
