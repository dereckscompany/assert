# Assert that an object contains required names

Checks that `x` has names and that every name in `names` is present.
This is the list or vector counterpart of
[`assert_has_columns()`](https://dereckscompany.github.io/assert/reference/assert_has_columns.md).
Extra names are allowed.

## Usage

``` r
assert_has_names(
  x,
  names,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- names:

  Character vector of names that must be present on `x`.

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
assert_has_names(list(host = "localhost", port = 8080), c("host", "port"))
```
