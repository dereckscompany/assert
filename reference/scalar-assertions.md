# Assert that an object is a single value of a given type

Each function checks that `x` has length exactly 1, is of the named
type, and is not `NA`. (A single value that is secretly `NA` is almost
always a bug, so it is rejected here; use the plain vector checks such
as
[`assert_character()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md)
if you want to allow `NA`.) On success the input is returned invisibly
so checks can be stacked; on failure an error is raised against the
calling function.

## Usage

``` r
assert_scalar_character(
  x,
  null_ok = FALSE,
  non_empty = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_scalar_numeric(
  x,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_scalar_integer(
  x,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_scalar_double(
  x,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_scalar_logical(
  x,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)

assert_scalar_complex(
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

- non_empty:

  Single logical, used by `assert_scalar_character()` only. If `TRUE`,
  the empty string `""` is rejected as well. Defaults to `FALSE`.

- arg:

  Name used to refer to `x` in error messages. Defaults to the name of
  the expression passed as `x`.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

The input `x`, invisibly.

## Details

`assert_scalar_character()` additionally accepts `non_empty`: set it to
`TRUE` to reject the empty string `""` as well, for arguments such as
identifiers or codes where an empty value is never valid.

## Examples

``` r
assert_scalar_character("hello")
assert_scalar_numeric(42)
assert_scalar_logical(TRUE)

# Optional argument that defaults to NULL:
assert_scalar_numeric(NULL, null_ok = TRUE)

# Reject empty strings for identifiers and codes:
assert_scalar_character("BTC/USDT", non_empty = TRUE)
```
