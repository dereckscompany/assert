# Assert that an object is a data table

Checks that `x` is a data.table. This only inspects the object's class
and does not require the data.table package to be loaded.

## Usage

``` r
assert_data_table(
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
df <- data.frame(a = 1, b = 2)
class(df) <- c("data.table", "data.frame")
assert_data_table(df)
```
