# Assert that values are whole numbers

Checks that `x` is numeric and every value has no fractional part.
Unlike
[`assert_integer()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
this accepts doubles such as `3` or `c(1, 2, 3)` as long as they are
integer-valued. Missing values cause the check to fail.

## Usage

``` r
assert_all_whole_numbers(
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
assert_all_whole_numbers(c(1, 2, 3))
assert_all_whole_numbers(4L)
```
