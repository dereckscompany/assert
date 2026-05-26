# Assert that a set of columns share a single type

Checks that `x` is a data frame containing every name in `columns`, and
that all of those columns are of `type`. Type names are matched as
described in
[`assert_column_types()`](https://dereckscompany.github.io/assert/reference/assert_column_types.md).

## Usage

``` r
assert_columns_are_type(
  x,
  columns,
  type,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- columns:

  Character vector of column names to check.

- type:

  Single string naming the type that every listed column must be.

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
measurements <- data.frame(height = 1.8, weight = 75.0)
assert_columns_are_type(measurements, c("height", "weight"), "numeric")
```
