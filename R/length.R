#' Assert that an object has an exact length
#'
#' @inheritParams scalar-assertions
#' @param expected_length Single non-negative whole number: the required length.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_length(1:3, 3)
#'
#' @export
assert_length <- function(x, expected_length, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != expected_length) {
    abort_assertion(arg, "have length {expected_length}", call)
  }
  return(invisible(x))
}

#' Assert that an object's length falls within bounds
#'
#' @inheritParams scalar-assertions
#' @param minimum_length Single non-negative whole number: the smallest
#'   allowed length.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_minimum_length(1:5, 3)
#'
#' @export
assert_minimum_length <- function(
  x,
  minimum_length,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) < minimum_length) {
    abort_assertion(arg, "have length of at least {minimum_length}", call)
  }
  return(invisible(x))
}

#' @rdname assert_minimum_length
#' @param maximum_length Single non-negative whole number: the largest
#'   allowed length.
#'
#' @examples
#' assert_maximum_length(1:5, 10)
#'
#' @export
assert_maximum_length <- function(
  x,
  maximum_length,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) > maximum_length) {
    abort_assertion(arg, "have length of at most {maximum_length}", call)
  }
  return(invisible(x))
}

#' Assert that an object is not empty
#'
#' Checks that `x` has length greater than zero.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_not_empty(1:3)
#'
#' @export
assert_not_empty <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) == 0L) {
    abort_assertion(arg, "not be empty", call)
  }
  return(invisible(x))
}

#' Assert that an object has names
#'
#' Checks that `x` has a names attribute and that every name is non-missing
#' and non-empty.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_named(c(a = 1, b = 2))
#'
#' @export
assert_named <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  object_names <- names(x)
  if (is.null(object_names) || any(is.na(object_names)) || any(object_names == "")) {
    abort_assertion(arg, "have names for every element", call)
  }
  return(invisible(x))
}

#' Assert that an object's names are unique
#'
#' Checks that `x` has names (see [assert_named()]) and that no name is
#' repeated.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_unique_names(c(a = 1, b = 2))
#'
#' @export
assert_unique_names <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_named(x, arg = arg, call = call)
  if (any(duplicated(names(x)))) {
    abort_assertion(arg, "have unique names", call)
  }
  return(invisible(x))
}

#' Assert that an object contains required names
#'
#' Checks that `x` has names and that every name in `names` is present. This is
#' the list or vector counterpart of [assert_has_columns()]. Extra names are
#' allowed.
#'
#' @inheritParams scalar-assertions
#' @param names Character vector of names that must be present on `x`.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_has_names(list(host = "localhost", port = 8080), c("host", "port"))
#'
#' @export
assert_has_names <- function(x, names, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  missing_names <- setdiff(names, base::names(x))
  if (length(missing_names) > 0L) {
    formatted <- paste(missing_names, collapse = ", ")
    abort_assertion(arg, paste0("contain the names: ", formatted), call)
  }
  return(invisible(x))
}
