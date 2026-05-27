
# assert <img src="man/figures/logo.png" alt="assert logo" align="right" height="139" />

`assert` is a lightweight toolkit of assertion helpers for checking the
inputs and outputs of your functions. Drop a few assertions at the top
of a function and get a clear, immediate error when an argument is the
wrong type, shape, or value.

## Why

Every assertion follows the same simple contract:

- **Checks one thing.** Each function tests a single, explicit
  condition.
- **Returns its input invisibly.** Checks can be stacked, one per line,
  reading like a checklist of preconditions.
- **Fails loudly and clearly.** On failure it throws an error that names
  the offending argument and points at *your* function, not at
  `assert`’s internals.
- **Explicit, readable names.** `assert_scalar_character()`, not
  `assert_chr()`.

## Installation

`assert` is not on CRAN; install it from GitHub with renv:

``` r
# first install renv itself if you don't have it: install.packages("renv")
renv::install("dereckscompany/assert")
```

## Usage

Write assertions at the top of a function. If one fails, it throws an
error and the function stops immediately.

``` r
box::use(
  assert[
    assert_numeric,
    assert_no_missing_values,
    assert_all_positive,
    assert_same_length
  ]
)

average_price <- function(prices, weights) {
  assert_numeric(prices)
  assert_no_missing_values(prices)
  assert_all_positive(prices)
  assert_same_length(prices, weights)

  return(sum(prices * weights) / sum(weights))
}

average_price(c(10, 20, 30), c(1, 1, 2))
#> [1] 22.5
```

When an input is invalid, the error names the argument and the calling
function:

``` r
average_price(c(10, -5, 30), c(1, 1, 2))
#> Error in `average_price()`:
#> ! `prices` must contain only positive values (greater than zero).
```

### Optional arguments

Arguments that default to `NULL` are optional. Pass `null_ok = TRUE` to
let the assertion accept `NULL` while still checking any value that is
supplied:

``` r
box::use(assert[assert_scalar_character, assert_scalar_integer])

connect <- function(host, port = NULL) {
  assert_scalar_character(host)
  assert_scalar_integer(port, null_ok = TRUE)
  return(invisible(TRUE))
}

connect("localhost")          # port omitted — fine
connect("localhost", 8080L)   # port supplied and valid — fine
```

### Stacking checks with the pipe

Because every assertion returns its input invisibly, checks compose
naturally with the native pipe `|>`. Each one validates the value and
hands it to the next, so a chain reads like a list of guarantees about
the same object:

``` r
box::use(assert[assert_data_frame, assert_has_columns, assert_column_types])

people <- data.frame(name = c("Ada", "Alan"), age = c(36L, 41L))

people |>
  assert_data_frame() |>
  assert_has_columns(c("name", "age")) |>
  assert_column_types("character", "name") |>
  assert_column_types("integer", "age") |>
  invisible()
```

## What it covers

| Group | Examples |
|----|----|
| Scalars | `assert_scalar_character()`, `assert_scalar_count()`, `assert_scalar_positive()` |
| Vectors | `assert_character()`, `assert_numeric()`, `assert_list()`, `assert_list_of()` |
| Dates & times | `assert_date()`, `assert_datetime()`, `assert_scalar_datetime()` |
| Ranges | `assert_range()`, `assert_between()` |
| Length & names | `assert_length()`, `assert_not_empty()`, `assert_named()`, `assert_has_names()` |
| Values | `assert_no_missing_values()`, `assert_all_positive()`, `assert_values_in_set()`, `assert_value_in_set()` |
| Strings | `assert_matches_pattern()`, `assert_nonempty_strings()`, `assert_minimum_characters()` |
| Comparisons | `assert_all_greater_than()`, `assert_all_less_than_or_equal()`, `assert_sorted()`, `assert_same_length()` |
| Sets | `assert_set_equal()`, `assert_disjoint()` |
| Arguments | `assert_mutually_exclusive()`, `assert_at_least_one()`, `assert_exactly_one()` |
| Data frames | `assert_data_frame()`, `assert_has_columns()`, `assert_column_types()`, `assert_unique_rows()` |
| Conditions | `assert_true()`, `assert_false()`, `assert_null()`, `assert_not_null()` |

See `vignette("assert")` for a tour.

## License

MIT © Dereck Mezquita. See [LICENSE](LICENSE) for details.

## Citation

If you use `assert` in your work, please cite it:

> Mezquita, D. (2026). assert.
> <https://github.com/dereckscompany/assert>. ORCID:
> [0000-0002-9307-6762](https://orcid.org/0000-0002-9307-6762)
