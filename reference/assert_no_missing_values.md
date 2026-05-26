# Assert that an object contains no missing values

Checks that `x` contains no missing values, that is, no `NA`. Note that
R also reports `NaN` ("Not a Number", such as `0 / 0`) as missing via
[`is.na()`](https://rdrr.io/r/base/NA.html), so `NaN` is caught here
too. To reject `NaN` and infinite values specifically as invalid
numbers, use
[`assert_all_finite()`](https://dereckscompany.github.io/assert/reference/assert_all_finite.md).

## Usage

``` r
assert_no_missing_values(
  x,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

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
assert_no_missing_values(c(1, 2, 3))
```
