# Assert that two objects hold the same set of values

Checks that `x` and `y` contain the same values, ignoring order and
duplicates (using [`setequal()`](https://rdrr.io/r/base/sets.html)).

## Usage

``` r
assert_set_equal(
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

  The object whose values `x` must match as a set.

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
assert_set_equal(c("a", "b", "b"), c("b", "a"))
```
