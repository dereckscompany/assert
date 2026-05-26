# String assertions check the number of characters in each element of a
# character vector. For pattern matching see assert_matches_pattern(), and for
# rejecting empty strings see assert_no_empty_strings().

#' Assert that strings have at least a minimum number of characters
#'
#' Checks that `x` is a character vector in which every element has at least
#' `minimum_characters` characters. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param minimum_characters Single non-negative whole number: the smallest
#'   allowed number of characters.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_minimum_characters(c("abc", "abcd"), 3)
#'
#' @export
assert_minimum_characters <- function(
  x,
  minimum_characters,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.character(x) || anyNA(x) || any(nchar(x) < minimum_characters)) {
    abort_assertion(arg, "contain only strings of at least {minimum_characters} character{?s}", call)
  }
  return(invisible(x))
}

#' Assert that strings have at most a maximum number of characters
#'
#' Checks that `x` is a character vector in which every element has at most
#' `maximum_characters` characters. Missing values cause the check to fail.
#'
#' @inheritParams scalar-assertions
#' @param maximum_characters Single non-negative whole number: the largest
#'   allowed number of characters.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_maximum_characters(c("abc", "ab"), 3)
#'
#' @export
assert_maximum_characters <- function(
  x,
  maximum_characters,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.character(x) || anyNA(x) || any(nchar(x) > maximum_characters)) {
    abort_assertion(arg, "contain only strings of at most {maximum_characters} character{?s}", call)
  }
  return(invisible(x))
}
