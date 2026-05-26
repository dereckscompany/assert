# Assert that a condition is true

A general-purpose check for any condition that does not have its own
dedicated assertion. `condition` must be a single `TRUE`; anything else
(`FALSE`, `NA`, a non-logical, or a vector) fails. Provide `message` to
describe the requirement in your own words.

## Usage

``` r
assert_true(
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
assert_true(x > 0)
assert_true(x %% 2 == 1, message = "x must be odd.")
```
