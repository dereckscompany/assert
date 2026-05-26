# Assert that values fall between two bounds

Checks that every element of `x` lies between `lower` and `upper`,
inclusive. Works for any comparable type: numbers, dates, date-times,
strings. Pass `NULL` for a bound to leave that side open. Missing values
cause the check to fail. For numeric-only bounds you may also use
[`assert_all_within_range()`](https://dereckscompany.github.io/assert/reference/assert_all_within_range.md).

## Usage

``` r
assert_between(
  x,
  lower = NULL,
  upper = NULL,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- lower:

  Lower bound (inclusive), or `NULL` for unbounded below.

- upper:

  Upper bound (inclusive), or `NULL` for unbounded above.

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
assert_between(5, 0, 10)
assert_between(Sys.time(), lower = as.POSIXct("2000-01-01"))
```
