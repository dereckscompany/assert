# Assert that a data frame contains required columns

Checks that `x` is a data frame and that every name in `columns` is
present among its columns. Extra columns are allowed.

## Usage

``` r
assert_has_columns(
  x,
  columns,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- columns:

  Character vector of column names that must be present.

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
assert_has_columns(data.frame(a = 1, b = 2, c = 3), c("a", "b"))
```
