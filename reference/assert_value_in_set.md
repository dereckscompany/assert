# Assert that a single value belongs to a set

Checks that `x` is a single value (length 1) equal to one of
`allowed_values`. The scalar counterpart of
[`assert_values_in_set()`](https://dereckscompany.github.io/assert/reference/assert_values_in_set.md),
which checks every element of a vector.

## Usage

``` r
assert_value_in_set(
  x,
  allowed_values,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- allowed_values:

  Vector of permitted values.

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
assert_value_in_set("b", allowed_values = c("a", "b", "c"))
```
