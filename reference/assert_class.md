# Assert that an object inherits from a class

Checks that `x` inherits from every class named in `class`, using
[`inherits()`](https://rdrr.io/r/base/class.html).

## Usage

``` r
assert_class(
  x,
  class,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- class:

  Character vector of one or more class names that `x` must inherit
  from.

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
assert_class(Sys.Date(), "Date")
```
