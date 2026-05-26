# Relational assertions compare an object against a threshold or against other
# objects, rather than checking a single object in isolation.

#' Assert element-wise numeric comparisons
#'
#' Each function checks that `x` is numeric and that every element compares as
#' required against `threshold`. `threshold` may be a single number (compared
#' against every element of `x`) or a numeric vector the same length as `x`
#' (compared element by element). Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param threshold A single number, or a numeric vector the same length as
#'   `x`, to compare against.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_all_greater_than(c(2, 3, 4), 1)
#' assert_all_less_than_or_equal(c(1, 2), c(1, 5))
#'
#' @name comparison-assertions
NULL

#' @rdname comparison-assertions
#' @export
assert_all_greater_than <- function(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x <= threshold)) {
    abort_assertion(arg, "be greater than {threshold}", call)
  }
  return(invisible(x))
}

#' @rdname comparison-assertions
#' @export
assert_all_greater_than_or_equal <- function(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x < threshold)) {
    abort_assertion(arg, "be greater than or equal to {threshold}", call)
  }
  return(invisible(x))
}

#' @rdname comparison-assertions
#' @export
assert_all_less_than <- function(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x >= threshold)) {
    abort_assertion(arg, "be less than {threshold}", call)
  }
  return(invisible(x))
}

#' @rdname comparison-assertions
#' @export
assert_all_less_than_or_equal <- function(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x > threshold)) {
    abort_assertion(arg, "be less than or equal to {threshold}", call)
  }
  return(invisible(x))
}

#' Assert that values are sorted
#'
#' Checks that `x` is in sorted order. By default the order must be
#' non-decreasing (ties allowed). Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param decreasing Single logical: if `TRUE`, require descending order
#'   instead of ascending. Defaults to `FALSE`.
#' @param strictly Single logical: if `TRUE`, require a strict order with no
#'   tied (equal) neighbouring values. Defaults to `FALSE`.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_sorted(c(1, 2, 2, 3))
#' assert_sorted(c(3, 2, 1), decreasing = TRUE)
#' assert_sorted(c(1, 2, 3), strictly = TRUE)
#'
#' @export
assert_sorted <- function(
  x,
  decreasing = FALSE,
  strictly = FALSE,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (anyNA(x)) {
    abort_assertion(arg, "not contain missing values to be checked for sorting", call)
  }
  # is.unsorted() works on any orderable type (numbers, strings, dates,
  # ordered factors) and stops at the first violation. For descending order we
  # check that the reversed vector is non-decreasing.
  ordered <- if (decreasing) {
    !is.unsorted(rev(x), strictly = strictly)
  } else {
    !is.unsorted(x, strictly = strictly)
  }
  if (!ordered) {
    direction <- if (decreasing) "descending" else "ascending"
    strictness <- if (strictly) " strictly" else ""
    abort_assertion(arg, paste0("be sorted in", strictness, " ", direction, " order"), call)
  }
  return(invisible(x))
}

#' Assert that objects share the same length
#'
#' Checks that every object passed in `...` has the same length. Useful before
#' element-wise operations on parallel vectors or columns.
#'
#' @param ... Two or more objects to compare. Their lengths must all be equal.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return The first object in `...`, invisibly.
#'
#' @examples
#' assert_same_length(c(1, 2, 3), c("a", "b", "c"))
#'
#' @export
assert_same_length <- function(..., call = rlang::caller_env()) {
  objects <- list(...)
  if (length(objects) < 2L) {
    cli::cli_abort("{.fn assert_same_length} needs at least two objects to compare.", call = call)
  }
  lengths <- vapply(objects, length, integer(1))
  if (length(unique(lengths)) != 1L) {
    formatted <- paste(lengths, collapse = ", ")
    cli::cli_abort(
      paste0("All objects must have the same length, but their lengths were ", formatted, "."),
      call = call
    )
  }
  return(invisible(objects[[1]]))
}
