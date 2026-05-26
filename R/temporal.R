# Date and date-time type assertions. These check the class only; they do not
# require lubridate (a lubridate date-time is a POSIXct and passes as-is).

#' Assert that an object is a date
#'
#' Checks that `x` is a date, that is, of class `Date` (as returned by
#' [Sys.Date()] and [as.Date()]). Allows any length; for a single value use
#' [assert_scalar_date()].
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_date(Sys.Date())
#'
#' @export
assert_date <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!inherits(x, "Date")) {
    abort_assertion(arg, "be a date ({.cls Date})", call)
  }
  return(invisible(x))
}

#' Assert that an object is a date-time
#'
#' Checks that `x` is a date-time, that is, of class `POSIXct` (as returned by
#' [Sys.time()], [as.POSIXct()], and lubridate functions such as `ymd_hms()`).
#' Allows any length; for a single value use [assert_scalar_datetime()].
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_datetime(Sys.time())
#'
#' @export
assert_datetime <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!inherits(x, "POSIXct")) {
    abort_assertion(arg, "be a date-time ({.cls POSIXct})", call)
  }
  return(invisible(x))
}

#' Assert that an object is a single date
#'
#' Checks that `x` has length exactly 1, is of class `Date`, and is not `NA`.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_scalar_date(Sys.Date())
#'
#' @export
assert_scalar_date <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !inherits(x, "Date") || is.na(x)) {
    abort_assertion(arg, "be a single date ({.cls Date}), not NA", call)
  }
  return(invisible(x))
}

#' Assert that an object is a single date-time
#'
#' Checks that `x` has length exactly 1, is of class `POSIXct`, and is not `NA`.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_scalar_datetime(Sys.time())
#'
#' @export
assert_scalar_datetime <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !inherits(x, "POSIXct") || is.na(x)) {
    abort_assertion(arg, "be a single date-time ({.cls POSIXct}), not NA", call)
  }
  return(invisible(x))
}
