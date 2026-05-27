#' Assert that an object is a data frame
#'
#' Checks that `x` is a data frame. Note that data tables and tibbles are also
#' data frames and pass this check.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_data_frame(data.frame(a = 1, b = 2))
#'
#' @export
assert_data_frame <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!is.data.frame(x)) {
    abort_assertion(arg, "be a data frame", call)
  }
  return(invisible(x))
}

#' Assert that an object is a data table
#'
#' Checks that `x` is a data.table. This only inspects the object's class and
#' does not require the data.table package to be loaded.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' df <- data.frame(a = 1, b = 2)
#' class(df) <- c("data.table", "data.frame")
#' assert_data_table(df)
#'
#' @export
assert_data_table <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  if (!inherits(x, "data.table")) {
    abort_assertion(arg, "be a data table", call)
  }
  return(invisible(x))
}

#' Assert that a data frame is not empty
#'
#' Checks that `x` is a data frame with at least one row and one column.
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_not_empty_data_frame(data.frame(a = 1))
#'
#' @export
assert_not_empty_data_frame <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  if (nrow(x) == 0L || ncol(x) == 0L) {
    abort_assertion(arg, "have at least one row and one column", call)
  }
  return(invisible(x))
}

#' Assert that a data frame has an exact number of rows
#'
#' @inheritParams scalar-assertions
#' @param expected_rows Single non-negative whole number: the required row count.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_number_of_rows(data.frame(a = 1:3), 3)
#'
#' @export
assert_number_of_rows <- function(
  x,
  expected_rows,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  if (nrow(x) != expected_rows) {
    abort_assertion(arg, "have {expected_rows} row{?s}", call)
  }
  return(invisible(x))
}

#' Assert that a data frame has an exact number of columns
#'
#' @inheritParams scalar-assertions
#' @param expected_columns Single non-negative whole number: the required
#'   column count.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_number_of_columns(data.frame(a = 1, b = 2), 2)
#'
#' @export
assert_number_of_columns <- function(
  x,
  expected_columns,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  if (ncol(x) != expected_columns) {
    abort_assertion(arg, "have {expected_columns} column{?s}", call)
  }
  return(invisible(x))
}

#' Assert that a data frame contains required columns
#'
#' Checks that `x` is a data frame and that every name in `columns` is present
#' among its columns. Extra columns are allowed.
#'
#' @inheritParams scalar-assertions
#' @param columns Character vector of column names that must be present.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_has_columns(data.frame(a = 1, b = 2, c = 3), c("a", "b"))
#'
#' @export
assert_has_columns <- function(x, columns, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  missing_columns <- setdiff(columns, names(x))
  if (length(missing_columns) > 0L) {
    formatted <- paste(missing_columns, collapse = ", ")
    abort_assertion(arg, paste0("contain the columns: ", formatted), call)
  }
  return(invisible(x))
}

#' Assert that a data frame has exactly these columns
#'
#' Checks that `x` is a data frame whose column names are exactly `columns`,
#' as a set. By default order does not matter.
#'
#' @inheritParams scalar-assertions
#' @param columns Character vector of the exact column names expected.
#' @param ordered Single logical: if `TRUE`, the columns must also appear in
#'   the given order. Defaults to `FALSE`.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_column_names(data.frame(a = 1, b = 2), c("a", "b"))
#'
#' @export
assert_column_names <- function(
  x,
  columns,
  ordered = FALSE,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  actual_names <- names(x)
  formatted <- paste(columns, collapse = ", ")
  if (ordered) {
    if (!identical(actual_names, columns)) {
      abort_assertion(arg, paste0("have exactly these columns, in order: ", formatted), call)
    }
  } else if (!setequal(actual_names, columns)) {
    abort_assertion(arg, paste0("have exactly these columns: ", formatted), call)
  }
  return(invisible(x))
}

#' Assert that columns of a data frame contain no missing values
#'
#' Checks that `x` is a data frame and that the named `columns` contain no
#' `NA` values. If `columns` is `NULL` (the default) every column is checked.
#'
#' @inheritParams scalar-assertions
#' @param columns Character vector of columns to check, or `NULL` for all
#'   columns.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_no_missing_in_columns(data.frame(a = 1:3, b = 4:6))
#'
#' @export
assert_no_missing_in_columns <- function(
  x,
  columns = NULL,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  if (is.null(columns)) {
    columns <- names(x)
  } else {
    assert_has_columns(x, columns, arg = arg, call = call)
  }
  columns_with_missing <- columns[vapply(columns, function(column) anyNA(x[[column]]), logical(1))]
  if (length(columns_with_missing) > 0L) {
    formatted <- paste(columns_with_missing, collapse = ", ")
    abort_assertion(arg, paste0("not contain missing values in columns: ", formatted), call)
  }
  return(invisible(x))
}

#' Test whether a value matches a named type
#'
#' Internal helper. Recognises the common base types by name and falls back to
#' [inherits()] for any other class name (for example "Date" or "factor").
#' Shared by the data-frame column checks and by [assert_list_of()].
#'
#' @param value The value (vector) to test.
#' @param type Single string naming the expected type.
#' @return `TRUE` if the value is of the named type, otherwise `FALSE`.
#' @noRd
value_matches_type <- function(value, type) {
  predicate <- switch(
    type,
    character = is.character,
    numeric = is.numeric,
    integer = is.integer,
    double = is.double,
    logical = is.logical,
    complex = is.complex,
    factor = is.factor,
    list = is.list,
    NULL
  )
  if (is.null(predicate)) {
    return(inherits(value, type))
  }
  return(predicate(value))
}

#' Assert that a set of columns are all of one type
#'
#' Checks that `x` is a data frame containing every name in `columns`, and that
#' all of those columns are of `type`. To validate several types, call again with
#' a different `type` and column set. Type names are matched as in
#' [is.character()], [is.numeric()], [is.integer()], [is.double()],
#' [is.logical()], [is.complex()], [is.factor()], and [is.list()]; any other
#' name is matched against the column's class with [inherits()] (for example
#' "Date").
#'
#' @inheritParams scalar-assertions
#' @param type Single string naming the type that every listed column must be.
#' @param columns Character vector of column names to check.
#'
#' @return The input `x`, invisibly.
#'
#' @examples
#' people <- data.frame(name = "Ada", height = 1.8, weight = 75.0)
#' assert_column_types(people, "numeric", c("height", "weight"))
#'
#' @export
assert_column_types <- function(x, type, columns, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  assert_has_columns(x, columns, arg = arg, call = call)

  wrong_columns <- columns[!vapply(columns, function(column) value_matches_type(x[[column]], type), logical(1))]
  if (length(wrong_columns) > 0L) {
    formatted <- paste(wrong_columns, collapse = ", ")
    abort_assertion(arg, paste0("have columns of type ", type, "; these are not: ", formatted), call)
  }
  return(invisible(x))
}

#' Assert that a data frame has no duplicate rows
#'
#' @inheritParams scalar-assertions
#' @return The input `x`, invisibly.
#'
#' @examples
#' assert_unique_rows(data.frame(a = c(1, 2), b = c(3, 4)))
#'
#' @export
assert_unique_rows <- function(x, null_ok = FALSE, arg = rlang::caller_arg(x), call = rlang::caller_env()) {
  if (passes_as_null(x, null_ok)) {
    return(invisible(x))
  }
  assert_data_frame(x, arg = arg, call = call)
  if (any(duplicated(x))) {
    abort_assertion(arg, "not contain duplicate rows", call)
  }
  return(invisible(x))
}
