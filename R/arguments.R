# Argument-group assertions express relationships between several arguments of
# a function, such as "supply exactly one of these". They treat a NULL argument
# as "not supplied" and a non-NULL argument as "supplied", which matches the
# common pattern of optional arguments defaulting to NULL.

#' Describe the arguments passed to an argument-group assertion
#'
#' Internal helper. Captures the supplied expressions so they can be named in
#' error messages, and reports how many were non-NULL ("supplied").
#'
#' @param quos A list of quosures captured with [rlang::enquos()].
#' @return A list with `labels` (the argument expressions as strings) and
#'   `supplied` (a logical vector marking which were non-NULL).
#' @noRd
describe_arguments <- function(quos) {
  labels <- vapply(quos, rlang::as_label, character(1))
  values <- lapply(quos, rlang::eval_tidy)
  supplied <- !vapply(values, is.null, logical(1))
  return(list(labels = labels, supplied = supplied))
}

#' Assert that at most one of several arguments is supplied
#'
#' Treats a `NULL` argument as "not supplied". Raises an error if two or more
#' of the arguments in `...` are non-`NULL`. Supplying none is allowed.
#'
#' @param ... Two or more arguments to check, typically optional parameters of
#'   the calling function that default to `NULL`.
#' @param call Environment used as the error's call context. Defaults to the
#'   calling function, so errors point at the user's code.
#'
#' @return `NULL`, invisibly.
#'
#' @examples
#' draw <- function(colour = NULL, palette = NULL) {
#'   assert_mutually_exclusive(colour, palette)
#'   "ok"
#' }
#' draw(colour = "red")
#'
#' @export
assert_mutually_exclusive <- function(..., call = rlang::caller_env()) {
  described <- describe_arguments(rlang::enquos(...))
  if (sum(described$supplied) > 1L) {
    supplied_labels <- paste(described$labels[described$supplied], collapse = ", ")
    cli::cli_abort(
      paste0("Only one of these may be supplied, but several were: ", supplied_labels, "."),
      call = call
    )
  }
  return(invisible(NULL))
}

#' Assert that at least one of several arguments is supplied
#'
#' Treats a `NULL` argument as "not supplied". Raises an error if every
#' argument in `...` is `NULL`.
#'
#' @inheritParams assert_mutually_exclusive
#' @return `NULL`, invisibly.
#'
#' @examples
#' fetch <- function(id = NULL, name = NULL) {
#'   assert_at_least_one(id, name)
#'   "ok"
#' }
#' fetch(name = "ada")
#'
#' @export
assert_at_least_one <- function(..., call = rlang::caller_env()) {
  described <- describe_arguments(rlang::enquos(...))
  if (!any(described$supplied)) {
    all_labels <- paste(described$labels, collapse = ", ")
    cli::cli_abort(
      paste0("At least one of these must be supplied: ", all_labels, "."),
      call = call
    )
  }
  return(invisible(NULL))
}

#' Assert that exactly one of several arguments is supplied
#'
#' Treats a `NULL` argument as "not supplied". Raises an error unless exactly
#' one argument in `...` is non-`NULL`.
#'
#' @inheritParams assert_mutually_exclusive
#' @return `NULL`, invisibly.
#'
#' @examples
#' connect <- function(url = NULL, socket = NULL) {
#'   assert_exactly_one(url, socket)
#'   "ok"
#' }
#' connect(url = "localhost")
#'
#' @export
assert_exactly_one <- function(..., call = rlang::caller_env()) {
  described <- describe_arguments(rlang::enquos(...))
  number_supplied <- sum(described$supplied)
  if (number_supplied != 1L) {
    all_labels <- paste(described$labels, collapse = ", ")
    cli::cli_abort(
      paste0(
        "Exactly one of these must be supplied: ", all_labels,
        " (", number_supplied, " were supplied)."
      ),
      call = call
    )
  }
  return(invisible(NULL))
}
