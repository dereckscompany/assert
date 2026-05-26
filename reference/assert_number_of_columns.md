# Assert that a data frame has an exact number of columns

Assert that a data frame has an exact number of columns

## Usage

``` r
assert_number_of_columns(
  x,
  expected_columns,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- expected_columns:

  Single non-negative whole number: the required column count.

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
assert_number_of_columns(data.frame(a = 1, b = 2), 2)
```
