# Assert that an object is a single non-negative number

Checks that `x` is a single, finite, non-negative number (zero or
greater). `NA`, `NaN`, `Inf`, and negative values are all rejected. The
zero-inclusive counterpart of
[`assert_scalar_positive()`](https://dereckscompany.github.io/assert/reference/assert_scalar_positive.md).

## Usage

``` r
assert_scalar_non_negative(
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
assert_scalar_non_negative(0)
assert_scalar_non_negative(42)
```
