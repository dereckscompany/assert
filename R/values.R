#' Assert that an object contains no missing values
#'
#' Checks that `x` contains no missing values, that is, no `NA`. Note that R
#' also reports `NaN` ("Not a Number", such as `0 / 0`) as missing via
#' [is.na()], so `NaN` is caught here too. To reject `NaN` and infinite values
#' specifically as invalid numbers, use [assert_all_finite()].
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_no_missing_values(c(1, 2, 3))
#'
#' @export
assert_no_missing_values <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (anyNA(x)) {
    abort_assertion(arg, "not contain missing values", call)
  }
  return(invisible(x))
}

#' Assert that an object contains no duplicate values
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_no_duplicates(c(1, 2, 3))
#'
#' @export
assert_no_duplicates <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (any(duplicated(x))) {
    abort_assertion(arg, "not contain duplicate values", call)
  }
  return(invisible(x))
}

#' Assert that all values are finite
#'
#' Checks that `x` is numeric and contains no `Inf`, `-Inf`, `NaN`, or `NA`
#' values.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_all_finite(c(1, 2, 3))
#'
#' @export
assert_all_finite <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || !all(is.finite(x))) {
    abort_assertion(arg, "contain only finite numeric values", call)
  }
  return(invisible(x))
}

#' Assert that values are whole numbers
#'
#' Checks that `x` is numeric and every value has no fractional part. Unlike
#' [assert_integer()], this accepts doubles such as `3` or `c(1, 2, 3)` as long
#' as they are integer-valued. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_all_whole_numbers(c(1, 2, 3))
#' assert_all_whole_numbers(4L)
#'
#' @export
assert_all_whole_numbers <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x != round(x))) {
    abort_assertion(arg, "contain only whole numbers", call)
  }
  return(invisible(x))
}

#' Assert that character values are not empty strings
#'
#' Checks that `x` is a character vector in which no element is the empty
#' string `""`. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_no_empty_strings(c("a", "b"))
#'
#' @export
assert_no_empty_strings <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.character(x) || anyNA(x) || any(!nzchar(x))) {
    abort_assertion(arg, "contain only non-empty strings", call)
  }
  return(invisible(x))
}

#' Assert the sign of all values
#'
#' Each function checks that `x` is numeric and that every value satisfies the
#' sign constraint. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_all_positive(c(1, 2, 3))
#' assert_all_non_negative(c(0, 1, 2))
#'
#' @name sign-assertions
NULL

#' @rdname sign-assertions
#' @export
assert_all_positive <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x <= 0)) {
    abort_assertion(arg, "contain only positive values (greater than zero)", call)
  }
  return(invisible(x))
}

#' @rdname sign-assertions
#' @export
assert_all_non_negative <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x < 0)) {
    abort_assertion(arg, "contain only non-negative values (zero or greater)", call)
  }
  return(invisible(x))
}

#' @rdname sign-assertions
#' @export
assert_all_negative <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x >= 0)) {
    abort_assertion(arg, "contain only negative values (less than zero)", call)
  }
  return(invisible(x))
}

#' @rdname sign-assertions
#' @export
assert_all_non_positive <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x > 0)) {
    abort_assertion(arg, "contain only non-positive values (zero or less)", call)
  }
  return(invisible(x))
}

#' Assert that all values fall within a range
#'
#' Checks that `x` is numeric and every value lies between `minimum` and
#' `maximum` inclusive. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param minimum Single number: the smallest allowed value.
#' @param maximum Single number: the largest allowed value.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_all_within_range(c(1, 5, 10), minimum = 0, maximum = 10)
#'
#' @export
assert_all_within_range <- function(
  x,
  minimum,
  maximum,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || anyNA(x) || any(x < minimum) || any(x > maximum)) {
    abort_assertion(arg, "contain only values between {minimum} and {maximum}", call)
  }
  return(invisible(x))
}

#' Assert that all values belong to a set
#'
#' Checks that every value in `x` appears in `allowed_values`. Missing values
#' cause the check to fail unless `NA` is itself one of the `allowed_values`.
#'
#' @inheritParams scalar-assertions
#' @param allowed_values Vector of permitted values.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_values_in_set(c("a", "b"), allowed_values = c("a", "b", "c"))
#'
#' @export
assert_values_in_set <- function(
  x,
  allowed_values,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!all(x %in% allowed_values)) {
    formatted <- paste(allowed_values, collapse = ", ")
    abort_assertion(arg, paste0("contain only these values: ", formatted), call)
  }
  return(invisible(x))
}

#' Assert that strings match a pattern
#'
#' Checks that `x` is a character vector and every element matches the regular
#' expression `pattern`. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param pattern Single string: a regular expression to match against.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_matches_pattern(c("abc", "abd"), pattern = "^ab")
#'
#' @export
assert_matches_pattern <- function(
  x,
  pattern,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.character(x) || !all(grepl(pattern, x))) {
    abort_assertion(arg, "match the pattern {.val {pattern}}", call)
  }
  return(invisible(x))
}
