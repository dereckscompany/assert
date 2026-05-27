# Changelog

## assert 0.0.6

- New
  [`assert_scalar_non_negative()`](https://dereckscompany.github.io/assert/reference/assert_scalar_non_negative.md):
  a single, finite, non-negative number (zero or greater) — the
  zero-inclusive counterpart of
  [`assert_scalar_positive()`](https://dereckscompany.github.io/assert/reference/assert_scalar_positive.md).
- New
  [`assert_scalar_positive_integer()`](https://dereckscompany.github.io/assert/reference/assert_scalar_positive_integer.md):
  a single positive whole number (`1`, `2`, `3`, …) — the
  strictly-positive counterpart of
  [`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md).

## assert 0.0.5

Naming and consistency cleanup.

- `assert_no_empty_strings()` renamed to
  [`assert_nonempty_strings()`](https://dereckscompany.github.io/assert/reference/assert_nonempty_strings.md).
- `assert_one_of()` renamed to
  [`assert_value_in_set()`](https://dereckscompany.github.io/assert/reference/assert_value_in_set.md),
  parallel with
  [`assert_values_in_set()`](https://dereckscompany.github.io/assert/reference/assert_values_in_set.md).
- [`assert_column_types()`](https://dereckscompany.github.io/assert/reference/assert_column_types.md)
  now checks that a set of `columns` are all one `type` —
  `assert_column_types(x, type, columns)`, stacked for multiple types.
  The previous named-list form and the separate
  `assert_columns_are_type()` are removed.
- `assert_all_within_range()` removed; use
  [`assert_between()`](https://dereckscompany.github.io/assert/reference/assert_between.md).

## assert 0.0.4

- Removed the `non_empty` argument from
  [`assert_scalar_character()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md)
  (added in 0.0.3). Compose with `assert_no_empty_strings()` to reject
  `""`, keeping the one-condition-per-function design.
- New
  [`assert_scalar_positive()`](https://dereckscompany.github.io/assert/reference/assert_scalar_positive.md):
  a single, finite, positive number — the positive-and-finite
  counterpart of
  [`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md).
- New `assert_one_of()`: a single value belonging to a set, the scalar
  counterpart of
  [`assert_values_in_set()`](https://dereckscompany.github.io/assert/reference/assert_values_in_set.md).
- [`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md)
  now rejects non-finite values (`Inf` previously passed).

## assert 0.0.3

- [`assert_scalar_character()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md)
  gains a `non_empty` argument. Set it to `TRUE` to also reject the
  empty string `""` — useful for identifiers and codes where an empty
  value is never valid. Defaults to `FALSE`, so existing behaviour is
  unchanged.

## assert 0.0.2

New assertions for dates, date-times, and ranges.

- **Date and date-time types**:
  [`assert_date()`](https://dereckscompany.github.io/assert/reference/assert_date.md),
  [`assert_datetime()`](https://dereckscompany.github.io/assert/reference/assert_datetime.md),
  [`assert_scalar_date()`](https://dereckscompany.github.io/assert/reference/assert_scalar_date.md),
  [`assert_scalar_datetime()`](https://dereckscompany.github.io/assert/reference/assert_scalar_datetime.md).
  The scalar forms require length 1 and reject `NA`. The date-time
  checks accept any `POSIXct`, including values created with lubridate.
- **Ranges** (work on any comparable type — numbers, dates, date-times,
  strings): `assert_range(lower, upper)` checks that two bounds form a
  sensible range (`lower <= upper`), treating a `NULL` bound as
  open-ended; `assert_between(x, lower, upper)` checks that values fall
  within bounds, with either bound optional.

## assert 0.0.1

First release of **assert**, a lightweight toolkit of readable assertion
helpers for validating function inputs and outputs.

Each assertion checks a single condition, returns its input invisibly so
checks can be stacked, and throws a clear, caller-aware error on
failure. Pass `null_ok = TRUE` to allow optional arguments that default
to `NULL`.

### Assertions

- **Scalars** (reject `NA`):
  [`assert_scalar_character()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_numeric()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_integer()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_double()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_logical()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_complex()`](https://dereckscompany.github.io/assert/reference/scalar-assertions.md),
  [`assert_scalar_count()`](https://dereckscompany.github.io/assert/reference/assert_scalar_count.md).
- **Vectors and objects**:
  [`assert_character()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_numeric()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_integer()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_double()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_logical()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_complex()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_list()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_factor()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_function()`](https://dereckscompany.github.io/assert/reference/vector-assertions.md),
  [`assert_class()`](https://dereckscompany.github.io/assert/reference/assert_class.md),
  [`assert_list_of()`](https://dereckscompany.github.io/assert/reference/assert_list_of.md).
- **Length and names**:
  [`assert_length()`](https://dereckscompany.github.io/assert/reference/assert_length.md),
  [`assert_minimum_length()`](https://dereckscompany.github.io/assert/reference/assert_minimum_length.md),
  [`assert_maximum_length()`](https://dereckscompany.github.io/assert/reference/assert_minimum_length.md),
  [`assert_not_empty()`](https://dereckscompany.github.io/assert/reference/assert_not_empty.md),
  [`assert_named()`](https://dereckscompany.github.io/assert/reference/assert_named.md),
  [`assert_unique_names()`](https://dereckscompany.github.io/assert/reference/assert_unique_names.md),
  [`assert_has_names()`](https://dereckscompany.github.io/assert/reference/assert_has_names.md).
- **Values**:
  [`assert_no_missing_values()`](https://dereckscompany.github.io/assert/reference/assert_no_missing_values.md),
  [`assert_no_duplicates()`](https://dereckscompany.github.io/assert/reference/assert_no_duplicates.md),
  [`assert_all_finite()`](https://dereckscompany.github.io/assert/reference/assert_all_finite.md),
  [`assert_all_whole_numbers()`](https://dereckscompany.github.io/assert/reference/assert_all_whole_numbers.md),
  `assert_no_empty_strings()`,
  [`assert_all_positive()`](https://dereckscompany.github.io/assert/reference/sign-assertions.md),
  [`assert_all_non_negative()`](https://dereckscompany.github.io/assert/reference/sign-assertions.md),
  [`assert_all_negative()`](https://dereckscompany.github.io/assert/reference/sign-assertions.md),
  [`assert_all_non_positive()`](https://dereckscompany.github.io/assert/reference/sign-assertions.md),
  `assert_all_within_range()`,
  [`assert_values_in_set()`](https://dereckscompany.github.io/assert/reference/assert_values_in_set.md),
  [`assert_matches_pattern()`](https://dereckscompany.github.io/assert/reference/assert_matches_pattern.md).
- **Strings**:
  [`assert_minimum_characters()`](https://dereckscompany.github.io/assert/reference/assert_minimum_characters.md),
  [`assert_maximum_characters()`](https://dereckscompany.github.io/assert/reference/assert_maximum_characters.md).
- **Comparisons and order**:
  [`assert_all_greater_than()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md),
  [`assert_all_greater_than_or_equal()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md),
  [`assert_all_less_than()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md),
  [`assert_all_less_than_or_equal()`](https://dereckscompany.github.io/assert/reference/comparison-assertions.md),
  [`assert_sorted()`](https://dereckscompany.github.io/assert/reference/assert_sorted.md),
  [`assert_same_length()`](https://dereckscompany.github.io/assert/reference/assert_same_length.md).
- **Sets**:
  [`assert_set_equal()`](https://dereckscompany.github.io/assert/reference/assert_set_equal.md),
  [`assert_disjoint()`](https://dereckscompany.github.io/assert/reference/assert_disjoint.md).
- **Argument groups**:
  [`assert_mutually_exclusive()`](https://dereckscompany.github.io/assert/reference/assert_mutually_exclusive.md),
  [`assert_at_least_one()`](https://dereckscompany.github.io/assert/reference/assert_at_least_one.md),
  [`assert_exactly_one()`](https://dereckscompany.github.io/assert/reference/assert_exactly_one.md).
- **Data frames and data tables**:
  [`assert_data_frame()`](https://dereckscompany.github.io/assert/reference/assert_data_frame.md),
  [`assert_data_table()`](https://dereckscompany.github.io/assert/reference/assert_data_table.md),
  [`assert_not_empty_data_frame()`](https://dereckscompany.github.io/assert/reference/assert_not_empty_data_frame.md),
  [`assert_number_of_rows()`](https://dereckscompany.github.io/assert/reference/assert_number_of_rows.md),
  [`assert_number_of_columns()`](https://dereckscompany.github.io/assert/reference/assert_number_of_columns.md),
  [`assert_has_columns()`](https://dereckscompany.github.io/assert/reference/assert_has_columns.md),
  [`assert_column_names()`](https://dereckscompany.github.io/assert/reference/assert_column_names.md),
  [`assert_no_missing_in_columns()`](https://dereckscompany.github.io/assert/reference/assert_no_missing_in_columns.md),
  [`assert_column_types()`](https://dereckscompany.github.io/assert/reference/assert_column_types.md),
  `assert_columns_are_type()`,
  [`assert_unique_rows()`](https://dereckscompany.github.io/assert/reference/assert_unique_rows.md).
- **Conditions**:
  [`assert_true()`](https://dereckscompany.github.io/assert/reference/assert_true.md),
  [`assert_false()`](https://dereckscompany.github.io/assert/reference/assert_false.md),
  [`assert_null()`](https://dereckscompany.github.io/assert/reference/assert_null.md),
  [`assert_not_null()`](https://dereckscompany.github.io/assert/reference/assert_not_null.md).
