# Assert that an object's length falls within bounds

Assert that an object's length falls within bounds

## Usage

``` r
assert_minimum_length(
  x,
  minimum_length,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_maximum_length(
  x,
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

- maximum_length:

  Single non-negative whole number: the largest allowed length.

## Value

The input `x`, invisibly.

## Examples

``` r
assert_minimum_length(1:5, 3)

assert_maximum_length(1:5, 10)
```
