# Assert element-wise numeric comparisons

Each function checks that `x` is numeric and that every element compares
as required against `threshold`. `threshold` may be a single number
(compared against every element of `x`) or a numeric vector the same
length as `x` (compared element by element). Missing values cause the
check to fail.

## Usage

``` r
assert_all_greater_than(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_all_greater_than_or_equal(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_all_less_than(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_all_less_than_or_equal(
  x,
  threshold,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- threshold:

  A single number, or a numeric vector the same length as `x`, to
  compare against.

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
assert_all_greater_than(c(2, 3, 4), 1)
assert_all_less_than_or_equal(c(1, 2), c(1, 5))
```
