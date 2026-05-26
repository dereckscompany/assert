#' Signal an assertion failure
#'
#' Internal helper. Builds a consistent error message of the form
#' "`arg` must <requirement>." and raises it in the caller's context.
#'
#' @param arg Name of the argument being checked, as a string.
#' @param requirement Human-readable description of what was expected,
#'   completing the sentence "`arg` must ...".
#' @param call Environment of the calling function, used so the error is
#'   reported against the user's function rather than against `assert`.
#' @param env Environment in which to resolve any glue placeholders inside
#'   `requirement` (such as `{expected_length}`). Defaults to the calling
#'   assertion function, where those values live.
#' @return Never returns; always throws an error.
#' @noRd
abort_assertion <- function(arg, requirement, call, env = parent.frame()) {
  requirement <- cli::format_inline(requirement, .envir = env)
  cli::cli_abort("{.arg {arg}} must {requirement}.", call = call)
}

#' Decide whether a NULL input should pass an assertion
#'
#' Internal helper. Returns `TRUE` when `x` is `NULL` and `NULL` is permitted,
#' signalling that the calling assertion should accept the input and return
#' early. Used at the top of every assertion to implement `null_ok`.
#'
#' @param x Object being checked.
#' @param null_ok Single logical: is `NULL` an acceptable value?
#' @return `TRUE` if the assertion should accept `x` and stop checking.
#' @noRd
passes_as_null <- function(x, null_ok) {
  return(isTRUE(null_ok) && is.null(x))
}

# ---- Scalar type assertions -------------------------------------------------
# A scalar is a value of length exactly 1. These check both the length and the
# type. Missing values (NA) are checked separately with assert_no_missing_values().

#' Assert that an object is a single value of a given type
#'
#' Each function checks that `x` has length exactly 1, is of the named type,
#' and is not `NA`. (A single value that is secretly `NA` is almost always a
#' bug, so it is rejected here; use the plain vector checks such as
#' [assert_character()] if you want to allow `NA`.) On success the input is
#' returned invisibly so checks can be stacked; on failure an error is raised
#' against the calling function.
#'
#' @param x Object to check.
#' @param null_ok Single logical. If `TRUE`, a `NULL` value passes the check
#'   without error. Use this for optional arguments that default to `NULL`.
#'   Defaults to `FALSE`, so `NULL` is rejected unless you opt in.
#' @param arg Name used to refer to `x` in error messages. Defaults to the
#'   name of the expression passed as `x`.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_scalar_character("hello")
#' assert_scalar_numeric(42)
#' assert_scalar_logical(TRUE)
#'
#' # Optional argument that defaults to NULL:
#' assert_scalar_numeric(NULL, null_ok = TRUE)
#'
#' @name scalar-assertions
NULL

#' @rdname scalar-assertions
#' @export
assert_scalar_character <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.character(x) || is.na(x)) {
    abort_assertion(arg, "be a single character value", call)
  }
  return(invisible(x))
}

#' @rdname scalar-assertions
#' @export
assert_scalar_numeric <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.numeric(x) || is.na(x)) {
    abort_assertion(arg, "be a single numeric value", call)
  }
  return(invisible(x))
}

#' @rdname scalar-assertions
#' @export
assert_scalar_integer <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.integer(x) || is.na(x)) {
    abort_assertion(arg, "be a single integer value", call)
  }
  return(invisible(x))
}

#' @rdname scalar-assertions
#' @export
assert_scalar_double <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.double(x) || is.na(x)) {
    abort_assertion(arg, "be a single double value", call)
  }
  return(invisible(x))
}

#' @rdname scalar-assertions
#' @export
assert_scalar_logical <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.logical(x) || is.na(x)) {
    abort_assertion(arg, "be a single logical value (TRUE or FALSE)", call)
  }
  return(invisible(x))
}

#' @rdname scalar-assertions
#' @export
assert_scalar_complex <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.complex(x) || is.na(x)) {
    abort_assertion(arg, "be a single complex value", call)
  }
  return(invisible(x))
}

# ---- Scalar value assertions ------------------------------------------------
# Convenience checks that combine "single value" with a content constraint.

#' Assert that an object is a single whole number used as a count
#'
#' Checks that `x` is a single non-negative whole number (`0`, `1`, `2`, ...).
#' Doubles with no fractional part (such as `3`) are accepted, as are integers.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_scalar_count(3)
#' assert_scalar_count(0L)
#'
#' @export
assert_scalar_count <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (length(x) != 1L || !is.numeric(x) || is.na(x) || x < 0 || x != round(x)) {
    abort_assertion(arg, "be a single non-negative whole number", call)
  }
  return(invisible(x))
}

# ---- Vector type assertions -------------------------------------------------
# These check the type but allow any length.

#' Assert that an object is a vector of a given type
#'
#' Each function checks that `x` is of the named type, allowing any length.
#' To also constrain the length, follow with [assert_length()]. On success
#' the input is returned invisibly; on failure an error is raised against the
#' calling function.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_character(c("a", "b", "c"))
#' assert_numeric(1:10)
#' assert_list(list(1, "a", TRUE))
#'
#' @name vector-assertions
NULL

#' @rdname vector-assertions
#' @export
assert_character <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.character(x)) {
    abort_assertion(arg, "be a character vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_numeric <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.numeric(x)) {
    abort_assertion(arg, "be a numeric vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_integer <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.integer(x)) {
    abort_assertion(arg, "be an integer vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_double <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.double(x)) {
    abort_assertion(arg, "be a double vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_logical <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.logical(x)) {
    abort_assertion(arg, "be a logical vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_complex <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.complex(x)) {
    abort_assertion(arg, "be a complex vector", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_list <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.list(x)) {
    abort_assertion(arg, "be a list", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_factor <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.factor(x)) {
    abort_assertion(arg, "be a factor", call)
  }
  return(invisible(x))
}

#' @rdname vector-assertions
#' @export
assert_function <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.function(x)) {
    abort_assertion(arg, "be a function", call)
  }
  return(invisible(x))
}

# ---- Object class assertion -------------------------------------------------

#' Assert that an object inherits from a class
#'
#' Checks that `x` inherits from every class named in `class`, using
#' [inherits()].
#'
#' @inheritParams scalar-assertions
#' @param class Character vector of one or more class names that `x` must
#'   inherit from.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_class(Sys.Date(), "Date")
#'
#' @export
assert_class <- function(x, class, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!all(vapply(class, function(cls) inherits(x, cls), logical(1)))) {
    requirement <- paste0("inherit from class {.cls ", paste(class, collapse = "/"), "}")
    abort_assertion(arg, requirement, call)
  }
  return(invisible(x))
}
