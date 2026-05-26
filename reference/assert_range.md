# Assert that two bounds form a range

Checks that `lower` is less than or equal to `upper`, so the two values
form a sensible (non-inverted) range. Works for any comparable type:
numbers, dates, date-times, strings. If either bound is `NULL` the range
is treated as open-ended on that side and the check passes — handy for
optional `start` / `end` arguments.

## Usage

``` r
assert_range(
  lower,
  upper,
  arg_lower = rlang::caller_arg(lower),
  arg_upper = rlang::caller_arg(upper),
  call = rlang::caller_env()
)
```

## Arguments

- lower:

  The lower bound, or `NULL` for unbounded below.

- upper:

  The upper bound, or `NULL` for unbounded above.

- arg_lower:

  Name used to refer to `lower` in error messages.

- arg_upper:

  Name used to refer to `upper` in error messages.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

`NULL`, invisibly.

## Examples

``` r
assert_range(0, 10)
assert_range(as.Date("2026-01-01"), as.Date("2026-12-31"))
assert_range(NULL, 10) # open-ended below: passes
```
