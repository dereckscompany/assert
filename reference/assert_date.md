# Assert that an object is a date

Checks that `x` is a date, that is, of class `Date` (as returned by
[`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html) and
[`as.Date()`](https://rdrr.io/r/base/as.Date.html)). Allows any length;
for a single value use
[`assert_scalar_date()`](https://dereckscompany.github.io/assert/reference/assert_scalar_date.md).

## Usage

``` r
assert_date(
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
assert_date(Sys.Date())
```
