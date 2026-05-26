# Assert that two objects share no values

Checks that `x` and `y` have no values in common (their intersection is
empty).

## Usage

``` r
assert_disjoint(
  x,
  y,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  arg_y = rlang::caller_arg(y),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- y:

  The object that `x` must not overlap with.

- null_ok:

  Single logical. If `TRUE`, a `NULL` value passes the check without
  error. Use this for optional arguments that default to `NULL`.
  Defaults to `FALSE`, so `NULL` is rejected unless you opt in.

- arg:

  Name used to refer to `x` in error messages. Defaults to the name of
  the expression passed as `x`.

- arg_y:

  Name used to refer to `y` in error messages. Defaults to the name of
  the expression passed as `y`.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

The input `x`, invisibly.

## Examples

``` r
assert_disjoint(c("a", "b"), c("c", "d"))
```
