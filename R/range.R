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

#' Assert that values fall within an interval
#'
#' Checks that every element of `x` lies within the interval `[lower, upper]`.
#' Each end is independently inclusive (closed, the default) or exclusive (open)
#' via `lower_inclusive` / `upper_inclusive`, so every interval shape is
#' expressible: `[a, b]`, `]a, b[`, `]a, b]`, `[a, b[`. Pass `NULL` for a bound to
#' leave that side unbounded (`]-Inf, b]`, `[a, Inf[`). Comparisons use only `<` /
#' `>`, so this works for any comparable type — numbers, integers, dates,
#' date-times, even strings — and never coerces.
#'
#' @inheritParams scalar-assertions
#' @param lower Lower bound, or `NULL` for unbounded below. Must be the same
#'   class as `x` (no coercion is performed); a mismatched class compares
#'   silently wrong.
#' @param upper Upper bound, or `NULL` for unbounded above.
#' @param lower_inclusive Single logical. If `TRUE` (default) the lower bound is
#'   inclusive (`x >= lower`); if `FALSE` it is exclusive (`x > lower`).
#' @param upper_inclusive Single logical. If `TRUE` (default) the upper bound is
#'   inclusive (`x <= upper`); if `FALSE` it is exclusive (`x < upper`).
#' @param na_ok Single logical. If `FALSE` (default) any `NA` in `x` fails the
#'   check; if `TRUE`, `NA` elements are ignored and only the non-missing values
#'   are range-checked.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_between(5, 0, 10) # [0, 10]
#' assert_between(0.5, 0, 1, lower_inclusive = FALSE) # ]0, 1]
#' assert_between(c(1, NA, 3), 0, 10, na_ok = TRUE)
#' assert_between(Sys.time(), lower = as.POSIXct("2000-01-01"))
#'
#' @export
assert_between <- function(
  x,
  lower = NULL,
  upper = NULL,
  lower_inclusive = TRUE,
  upper_inclusive = TRUE,
  na_ok = FALSE,
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
    if (!isTRUE(na_ok)) {
      abort_assertion(arg, "not contain missing values", call)
    }
    x <- x[!is.na(x)]
  }
  if (!is.null(lower)) {
    if (isTRUE(lower_inclusive)) {
      if (any(x < lower)) abort_assertion(arg, "be at least {lower}", call)
    } else {
      if (any(x <= lower)) abort_assertion(arg, "be greater than {lower}", call)
    }
  }
  if (!is.null(upper)) {
    if (isTRUE(upper_inclusive)) {
      if (any(x > upper)) abort_assertion(arg, "be at most {upper}", call)
    } else {
      if (any(x >= upper)) abort_assertion(arg, "be less than {upper}", call)
    }
  }
  return(invisible(x))
}
