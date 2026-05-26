# Assert that a data frame has exactly these columns

Checks that `x` is a data frame whose column names are exactly
`columns`, as a set. By default order does not matter.

## Usage

``` r
assert_column_names(
  x,
  columns,
  ordered = FALSE,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- columns:

  Character vector of the exact column names expected.

- ordered:

  Single logical: if `TRUE`, the columns must also appear in the given
  order. Defaults to `FALSE`.

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
assert_column_names(data.frame(a = 1, b = 2), c("a", "b"))
```
