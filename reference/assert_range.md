# Assert that two bounds form a range

Checks that `lower` and `upper` form a sensible (non-inverted) range. By
default equal bounds are allowed (`lower <= upper`, a point range); set
`allow_equal = FALSE` to require them strictly ordered
(`lower < upper`), rejecting `lower == upper` — handy for half-open
windows like `start < end`. Works for any comparable type: numbers,
dates, date-times, strings. If either bound is `NULL` the range is
treated as open-ended on that side and the check passes — handy for
optional `start` / `end` arguments.

## Usage

``` r
assert_range(
  lower,
  upper,
  allow_equal = TRUE,
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

- allow_equal:

  Single logical. If `TRUE` (default) the bounds may be equal
  (`lower <= upper`); if `FALSE` they must be strictly ordered
  (`lower < upper`), so equal bounds fail.

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
assert_range(5, 5) # equal bounds: passes by default
assert_range(5, 6, allow_equal = FALSE) # strict ordering required
assert_range(as.Date("2026-01-01"), as.Date("2026-12-31"))
assert_range(NULL, 10) # open-ended below: passes
```
