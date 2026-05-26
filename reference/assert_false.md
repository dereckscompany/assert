# Assert that a condition is false

The counterpart of
[`assert_true()`](https://dereckscompany.github.io/assert/reference/assert_true.md).
`condition` must be a single `FALSE`.

## Usage

``` r
assert_false(
  condition,
  message = NULL,
  arg = rlang::caller_arg(condition),
  call = rlang::caller_env()
)
```

## Arguments

- condition:

  A single logical value that must be `TRUE`.

- message:

  Optional custom error message. If omitted, a generic message naming
  the condition expression is used.

- arg:

  Name used to refer to `condition` in the default error message.
  Defaults to the condition expression.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

The input `condition`, invisibly.

## Examples

``` r
x <- 5
assert_false(x < 0)
```
