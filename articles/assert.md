# Getting started with assert

## The idea

`assert` gives you small, explicit helpers for checking the inputs and
outputs of your functions. You place assertions at the top of a
function; if one fails, it throws an error and the function stops before
any real work happens.

Every assertion shares the same contract:

- it checks **one** condition,
- it returns its input **invisibly** on success, so checks stack neatly,
- it throws a clear error **pointing at your function** on failure.

## Guarding inputs

``` r

scale_values <- function(values, factor) {
  assert_numeric(values)
  assert_no_missing_values(values)
  assert_scalar_numeric(factor)

  values * factor
}

scale_values(c(1, 2, 3), 10)
#> [1] 10 20 30
```

Read top to bottom, the assertions describe the preconditions: “`values`
is numeric, has no missing values; `factor` is a single number.” When
something is wrong, the message names the argument and the calling
function:

``` r

scale_values(c(1, NA, 3), 10)
#> Error in `scale_values()`:
#> ! `values` must not contain missing values.
```

``` r

scale_values(c(1, 2, 3), c(10, 20))
#> Error in `scale_values()`:
#> ! `factor` must be a single numeric value.
```

## Scalars reject `NA`

A `assert_scalar_*` check requires a single, non-`NA` value, because a
lone value that is secretly `NA` is almost always a mistake. The plain
vector checks
([`assert_numeric()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
[`assert_character()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
…) still allow `NA`, since a missing value among many is often
legitimate.

``` r

assert_scalar_numeric(NA)
#> Error:
#> ! `NA` must be a single numeric value.
```

## Optional arguments with `null_ok`

Arguments that default to `NULL` are optional. By default an assertion
rejects `NULL`; pass `null_ok = TRUE` to allow it while still validating
any value that *is* supplied.

``` r

greet <- function(name, title = NULL) {
  assert_scalar_character(name)
  assert_scalar_character(title, null_ok = TRUE)

  if (is.null(title)) name else paste(title, name)
}

greet("Ada")
#> [1] "Ada"
greet("Lovelace", title = "Ms")
#> [1] "Ms Lovelace"
```

## Constraining values

Beyond types, you can assert the *content* of a vector.

``` r

assert_all_positive(c(1, 2, 3))
assert_all_within_range(c(0.2, 0.5, 0.9), minimum = 0, maximum = 1)
assert_values_in_set(c("buy", "sell"), c("buy", "sell", "hold"))
invisible(NULL)
```

## Relationships between arguments

When several optional arguments interact, the argument-group helpers
express the rule directly. They treat `NULL` as “not supplied”.

``` r

open_file <- function(path = NULL, connection = NULL) {
  assert_exactly_one(path, connection)
  "ok"
}

open_file(path = "data.csv")
#> [1] "ok"
open_file()  # neither supplied
#> Error in `open_file()`:
#> ! Exactly one of these must be supplied: path, connection (0 were
#>   supplied).
```

## Checking data frames

Data frame helpers check structure and column types in one place.

``` r

trades <- data.frame(
  symbol = c("AAA", "BBB"),
  quantity = c(10L, 5L),
  price = c(1.5, 2.0)
)

trades |>
  assert_data_frame() |>
  assert_has_columns(c("symbol", "quantity", "price")) |>
  assert_column_types(list(symbol = "character", quantity = "integer", price = "numeric")) |>
  assert_unique_rows() |>
  invisible()
```

## The escape hatch

For any condition without a dedicated assertion, use
[`assert_true()`](https://dereckscompany.github.io/assert/reference/assert_true.md)
with a custom message.

``` r

set_threshold <- function(x) {
  assert_scalar_numeric(x)
  assert_true(x %% 2 == 0, message = "`x` must be an even number.")
  x
}

set_threshold(4)
#> [1] 4
set_threshold(3)
#> Error in `set_threshold()`:
#> ! `x` must be an even number.
```
