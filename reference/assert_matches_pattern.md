# Assert that strings match a pattern

Checks that `x` is a character vector and every element matches the
regular expression `pattern`. Missing values cause the check to fail.

## Usage

``` r
assert_matches_pattern(
  x,
  pattern,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- pattern:

  Single string: a regular expression to match against.

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
assert_matches_pattern(c("abc", "abd"), pattern = "^ab")
```
