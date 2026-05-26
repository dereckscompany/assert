# assert

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
- **Explicit, readable names.**
  [`assert_scalar_character()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  not `assert_chr()`.

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
  assert_column_types(list(name = "character", age = "integer")) |>
  invisible()
```

## What it covers

| Group | Examples |
|----|----|
| Scalars | [`assert_scalar_character()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md), [`assert_scalar_integer()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md), [`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md) |
| Vectors | [`assert_character()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md), [`assert_numeric()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md), [`assert_list()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md), [`assert_list_of()`](https://dereckscompany.github.io/assert/reference/assert_list_of.md) |
| Dates & times | [`assert_date()`](https://dereckscompany.github.io/assert/reference/assert_date.md), [`assert_datetime()`](https://dereckscompany.github.io/assert/reference/assert_datetime.md), [`assert_scalar_datetime()`](https://dereckscompany.github.io/assert/reference/assert_scalar_datetime.md) |
| Ranges | [`assert_range()`](https://dereckscompany.github.io/assert/reference/assert_range.md), [`assert_between()`](https://dereckscompany.github.io/assert/reference/assert_between.md) |
| Length & names | [`assert_length()`](https://dereckscompany.github.io/assert/reference/assert_length.md), [`assert_not_empty()`](https://dereckscompany.github.io/assert/reference/assert_not_empty.md), [`assert_named()`](https://dereckscompany.github.io/assert/reference/assert_named.md), [`assert_has_names()`](https://dereckscompany.github.io/assert/reference/assert_has_names.md) |
| Values | [`assert_no_missing_values()`](https://dereckscompany.github.io/assert/reference/assert_no_missing_values.md), [`assert_all_positive()`](https://dereckscompany.github.io/assert/reference/sign-assertions.md), [`assert_all_within_range()`](https://dereckscompany.github.io/assert/reference/assert_all_within_range.md), [`assert_values_in_set()`](https://dereckscompany.github.io/assert/reference/assert_values_in_set.md) |
| Strings | [`assert_matches_pattern()`](https://dereckscompany.github.io/assert/reference/assert_matches_pattern.md), [`assert_no_empty_strings()`](https://dereckscompany.github.io/assert/reference/assert_no_empty_strings.md), [`assert_minimum_characters()`](https://dereckscompany.github.io/assert/reference/assert_minimum_characters.md) |
| Comparisons | [`assert_all_greater_than()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md), [`assert_all_less_than_or_equal()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md), [`assert_sorted()`](https://dereckscompany.github.io/assert/reference/assert_sorted.md), [`assert_same_length()`](https://dereckscompany.github.io/assert/reference/assert_same_length.md) |
| Sets | [`assert_set_equal()`](https://dereckscompany.github.io/assert/reference/assert_set_equal.md), [`assert_disjoint()`](https://dereckscompany.github.io/assert/reference/assert_disjoint.md) |
| Arguments | [`assert_mutually_exclusive()`](https://dereckscompany.github.io/assert/reference/assert_mutually_exclusive.md), [`assert_at_least_one()`](https://dereckscompany.github.io/assert/reference/assert_at_least_one.md), [`assert_exactly_one()`](https://dereckscompany.github.io/assert/reference/assert_exactly_one.md) |
| Data frames | [`assert_data_frame()`](https://dereckscompany.github.io/assert/reference/assert_data_frame.md), [`assert_has_columns()`](https://dereckscompany.github.io/assert/reference/assert_has_columns.md), [`assert_column_types()`](https://dereckscompany.github.io/assert/reference/assert_column_types.md), [`assert_unique_rows()`](https://dereckscompany.github.io/assert/reference/assert_unique_rows.md) |
| Conditions | [`assert_true()`](https://dereckscompany.github.io/assert/reference/assert_true.md), [`assert_false()`](https://dereckscompany.github.io/assert/reference/assert_false.md), [`assert_null()`](https://dereckscompany.github.io/assert/reference/assert_null.md), [`assert_not_null()`](https://dereckscompany.github.io/assert/reference/assert_not_null.md) |

See
[`vignette("assert")`](https://dereckscompany.github.io/assert/articles/assert.md)
for a tour.

## License

MIT © Dereck Mezquita. See
[LICENSE](https://dereckscompany.github.io/assert/LICENSE) for details.

## Citation

If you use `assert` in your work, please cite it:

> Mezquita, D. (2026). assert.
> <https://github.com/dereckscompany/assert>. ORCID:
> [0000-0002-9307-6762](https://orcid.org/0000-0002-9307-6762)
