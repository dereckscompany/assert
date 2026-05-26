# Assert that all values fall within a range

Checks that `x` is numeric and every value lies between `minimum` and
`maximum` inclusive. Missing values cause the check to fail.

## Usage

``` r
assert_all_within_range(
  x,
  minimum,
  maximum,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- minimum:

  Single number: the smallest allowed value.

- maximum:

  Single number: the largest allowed value.

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
assert_all_within_range(c(1, 5, 10), minimum = 0, maximum = 10)
```
