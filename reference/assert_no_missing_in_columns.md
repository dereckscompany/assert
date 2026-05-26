# Assert that columns of a data frame contain no missing values

Checks that `x` is a data frame and that the named `columns` contain no
`NA` values. If `columns` is `NULL` (the default) every column is
checked.

## Usage

``` r
assert_no_missing_in_columns(
  x,
  columns = NULL,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- columns:

  Character vector of columns to check, or `NULL` for all columns.

- null_ok:

  Single logical. If `TRUE`, a `NULL` value passes the check without
  error. Use this for optional arguments that default to `NULL`.
  Defaults to `FALSE`, so `NULL` is rejected unless you opt in.

- arg:

  Name used to refer to `x` in error messages. Defaults to the name of
  the expression passed as `x`.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

The input `x`, invisibly.

## Examples

``` r
assert_no_missing_in_columns(data.frame(a = 1:3, b = 4:6))
```
