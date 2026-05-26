# Assert that values are sorted

Checks that `x` is in sorted order. By default the order must be
non-decreasing (ties allowed). Missing values cause the check to fail.

## Usage

``` r
assert_sorted(
  x,
  decreasing = FALSE,
  strictly = FALSE,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- decreasing:

  Single logical: if `TRUE`, require descending order instead of
  ascending. Defaults to `FALSE`.

- strictly:

  Single logical: if `TRUE`, require a strict order with no tied (equal)
  neighbouring values. Defaults to `FALSE`.

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
assert_sorted(c(1, 2, 2, 3))
assert_sorted(c(3, 2, 1), decreasing = TRUE)
assert_sorted(c(1, 2, 3), strictly = TRUE)
```
