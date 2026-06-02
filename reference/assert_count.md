# Assert that values are counts

Checks that `x` is numeric and every value is a non-negative whole
number (`0`, `1`, `2`, ...). Doubles with no fractional part (such as
`3` or `c(1, 2, 3)`) are accepted, as are integers. The vector
counterpart of
[`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md);
missing, infinite, fractional, and negative values all cause the check
to fail.

## Usage

``` r
assert_count(
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
assert_count(c(0, 1, 2))
assert_count(4L)
```
