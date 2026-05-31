# Assert that values fall within an interval

Checks that every element of `x` lies within the interval
`[lower, upper]`. Each end is independently inclusive (closed, the
default) or exclusive (open) via `lower_inclusive` / `upper_inclusive`,
so every interval shape is expressible: `[a, b]`, `]a, b[`, `]a, b]`,
`[a, b[`. Pass `NULL` for a bound to leave that side unbounded
(`]-Inf, b]`, `[a, Inf[`). Comparisons use only `<` / `>`, so this works
for any comparable type — numbers, integers, dates, date-times, even
strings — and never coerces.

## Usage

``` r
assert_between(
  x,
  lower = NULL,
  upper = NULL,
  lower_inclusive = TRUE,
  upper_inclusive = TRUE,
  na_ok = FALSE,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- lower:

  Lower bound, or `NULL` for unbounded below. Must be the same class as
  `x` (no coercion is performed); a mismatched class compares silently
  wrong.

- upper:

  Upper bound, or `NULL` for unbounded above.

- lower_inclusive:

  Single logical. If `TRUE` (default) the lower bound is inclusive
  (`x >= lower`); if `FALSE` it is exclusive (`x > lower`).

- upper_inclusive:

  Single logical. If `TRUE` (default) the upper bound is inclusive
  (`x <= upper`); if `FALSE` it is exclusive (`x < upper`).

- na_ok:

  Single logical. If `FALSE` (default) any `NA` in `x` fails the check;
  if `TRUE`, `NA` elements are ignored and only the non-missing values
  are range-checked. Either way `x` is returned unchanged (including any
  `NA`).

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
assert_between(5, 0, 10) # [0, 10]
assert_between(0.5, 0, 1, lower_inclusive = FALSE) # ]0, 1]
assert_between(c(1, NA, 3), 0, 10, na_ok = TRUE)
assert_between(Sys.time(), lower = as.POSIXct("2000-01-01"))
```
