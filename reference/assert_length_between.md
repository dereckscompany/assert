# Assert that an object's length falls within an inclusive range

Checks that `minimum_length <= length(x) <= maximum_length`, both
inclusive. The single-call form of stacking
[`assert_minimum_length()`](https://dereckscompany.github.io/assert/reference/assert_minimum_length.md)
and
[`assert_maximum_length()`](https://dereckscompany.github.io/assert/reference/assert_minimum_length.md).

## Usage

``` r
assert_length_between(
  x,
  minimum_length,
  maximum_length,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- minimum_length:

  Single non-negative whole number: the smallest allowed length.

- maximum_length:

  Single non-negative whole number: the largest allowed length.

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
assert_length_between(1:5, 1, 10)
```
