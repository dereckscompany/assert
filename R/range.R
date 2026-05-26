# Range assertions work on any comparable type — numbers, dates, date-times,
# even strings — because they rely only on the `<` / `>` operators, which R
# defines for all of these.

#' Assert that two bounds form a range
#'
#' Checks that `lower` is less than or equal to `upper`, so the two values form
#' a sensible (non-inverted) range. Works for any comparable type: numbers,
#' dates, date-times, strings. If either bound is `NULL` the range is treated as
#' open-ended on that side and the check passes — handy for optional `start` /
#' `end` arguments.
#'
#' @param lower The lower bound, or `NULL` for unbounded below.
#' @param upper The upper bound, or `NULL` for unbounded above.
#' @param arg_lower Name used to refer to `lower` in error messages.
#' @param arg_upper Name used to refer to `upper` in error messages.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return `NULL`, invisibly.
#'
#' @examples
#' assert_range(0, 10)
#' assert_range(as.Date("2026-01-01"), as.Date("2026-12-31"))
#' assert_range(NULL, 10) # open-ended below: passes
#'
#' @export
assert_range <- function(
  lower,
  upper,
  arg_lower = rlang::caller_arg(lower),
  arg_upper = rlang::caller_arg(upper),
  call = rlang::caller_env()
) {
  if (is.null(lower) || is.null(upper)) {
    return(invisible(NULL))
  }
  if (isTRUE(any(lower > upper))) {
    cli::cli_abort(
      "{.arg {arg_lower}} must be less than or equal to {.arg {arg_upper}}.",
      call = call
    )
  }
  return(invisible(NULL))
}

#' Assert that values fall between two bounds
#'
#' Checks that every element of `x` lies between `lower` and `upper`, inclusive.
#' Works for any comparable type: numbers, dates, date-times, strings. Pass
#' `NULL` for a bound to leave that side open. Missing values cause the check to
#' fail.
#'
#' @inheritParams scalar-assertions
#' @param lower Lower bound (inclusive), or `NULL` for unbounded below.
#' @param upper Upper bound (inclusive), or `NULL` for unbounded above.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_between(5, 0, 10)
#' assert_between(Sys.time(), lower = as.POSIXct("2000-01-01"))
#'
#' @export
assert_between <- function(
  x,
  lower = NULL,
  upper = NULL,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (is.null(lower) && is.null(upper)) {
    cli::cli_abort("Provide at least one of {.arg lower} or {.arg upper}.", call = call)
  }
  if (anyNA(x)) {
    abort_assertion(arg, "not contain missing values", call)
  }
  if (!is.null(lower) && any(x < lower)) {
    abort_assertion(arg, "be at least {lower}", call)
  }
  if (!is.null(upper) && any(x > upper)) {
    abort_assertion(arg, "be at most {upper}", call)
  }
  return(invisible(x))
}
