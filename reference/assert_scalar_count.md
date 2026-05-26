# Assert that an object is a single whole number used as a count

Checks that `x` is a single non-negative whole number (`0`, `1`, `2`,
...). Doubles with no fractional part (such as `3`) are accepted, as are
integers.

## Usage

``` r
assert_scalar_count(
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
assert_scalar_count(3)
assert_scalar_count(0L)
```
