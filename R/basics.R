#' Assert that a condition is true
#'
#' A general-purpose check for any condition that does not have its own
#' dedicated assertion. `condition` must be a single `TRUE`; anything else
#' (`FALSE`, `NA`, a non-logical, or a vector) fails. Provide `message` to
#' describe the requirement in your own words.
#'
#' @param condition A single logical value that must be `TRUE`.
#' @param message Optional custom error message. If omitted, a generic message
#'   naming the condition expression is used.
#' @param arg Name used to refer to `condition` in the default error message.
#'   Defaults to the condition expression.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return The input `condition`, invisibly.
#'
#' @examples
#' x <- 5
#' assert_true(x > 0)
#' assert_true(x %% 2 == 1, message = "x must be odd.")
#'
#' @export
assert_true <- function(condition, message = NULL, arg = rlang::caller_arg(condition), call = rlang::caller_env()) {
  if (!isTRUE(condition)) {
    if (is.null(message)) {
      abort_assertion(arg, "be TRUE", call)
    }
    cli::cli_abort(message, call = call)
  }
  return(invisible(condition))
}

#' Assert that a condition is false
#'
#' The counterpart of [assert_true()]. `condition` must be a single `FALSE`.
#'
#' @inheritParams assert_true
#' @return The input `condition`, invisibly.
#'
#' @examples
#' x <- 5
#' assert_false(x < 0)
#'
#' @export
assert_false <- function(condition, message = NULL, arg = rlang::caller_arg(condition), call = rlang::caller_env()) {
  if (!isFALSE(condition)) {
    if (is.null(message)) {
      abort_assertion(arg, "be FALSE", call)
    }
    cli::cli_abort(message, call = call)
  }
  return(invisible(condition))
}

#' Assert that an object is NULL
#'
#' @param x Object to check.
#' @param arg Name used to refer to `x` in error messages. Defaults to the
#'   name of the expression passed as `x`.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_null(NULL)
#'
#' @export
assert_null <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (!is.null(x)) {
    abort_assertion(arg, "be NULL", call)
  }
  return(invisible(x))
}

#' Assert that an object is not NULL
#'
#' @inheritParams assert_null
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_not_null(42)
#'
#' @export
assert_not_null <- function(x, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (is.null(x)) {
    abort_assertion(arg, "not be NULL", call)
  }
  return(invisible(x))
}

#' Assert that every element of a list is of a given type
#'
#' Checks that `x` is a list and that each of its elements is of `type`. Type
#' names are matched as in [is.character()], [is.numeric()], [is.integer()],
#' [is.double()], [is.logical()], [is.complex()], [is.factor()], and
#' [is.list()]; any other name is matched against each element's class with
#' [inherits()] (for example "Date").
#'
#' @inheritParams scalar-assertions
#' @param type Single string naming the type every element must be.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_list_of(list("a", "b", "c"), "character")
#' assert_list_of(list(1, 2, 3), "numeric")
#'
#' @export
assert_list_of <- function(x, type, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.list(x)) {
    abort_assertion(arg, "be a list", call)
  }
  if (!all(vapply(x, value_matches_type, logical(1), type = type))) {
    abort_assertion(arg, paste0("be a list whose elements are all of type ", type), call)
  }
  return(invisible(x))
}
