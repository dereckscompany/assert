# assert 0.0.6

* New `assert_scalar_non_negative()`: a single, finite, non-negative number (zero or greater) — the zero-inclusive counterpart of `assert_scalar_positive()`.
* New `assert_scalar_positive_integer()`: a single positive whole number (`1`, `2`, `3`, ...) — the strictly-positive counterpart of `assert_scalar_count()`.

# assert 0.0.5

Naming and consistency cleanup.

* `assert_no_empty_strings()` renamed to `assert_nonempty_strings()`.
* `assert_one_of()` renamed to `assert_value_in_set()`, parallel with `assert_values_in_set()`.
* `assert_column_types()` now checks that a set of `columns` are all one `type` — `assert_column_types(x, type, columns)`, stacked for multiple types. The previous named-list form and the separate `assert_columns_are_type()` are removed.
* `assert_all_within_range()` removed; use `assert_between()`.

# assert 0.0.4

* Removed the `non_empty` argument from `assert_scalar_character()` (added in
  0.0.3). Compose with `assert_no_empty_strings()` to reject `""`, keeping the
  one-condition-per-function design.
* New `assert_scalar_positive()`: a single, finite, positive number — the
  positive-and-finite counterpart of `assert_scalar_count()`.
* New `assert_one_of()`: a single value belonging to a set, the scalar
  counterpart of `assert_values_in_set()`.
* `assert_scalar_count()` now rejects non-finite values (`Inf` previously
  passed).

# assert 0.0.3

* `assert_scalar_character()` gains a `non_empty` argument. Set it to `TRUE` to
  also reject the empty string `""` — useful for identifiers and codes where an
  empty value is never valid. Defaults to `FALSE`, so existing behaviour is
  unchanged.

# assert 0.0.2

New assertions for dates, date-times, and ranges.

* **Date and date-time types**: `assert_date()`, `assert_datetime()`,
  `assert_scalar_date()`, `assert_scalar_datetime()`. The scalar forms require
  length 1 and reject `NA`. The date-time checks accept any `POSIXct`, including
  values created with lubridate.
* **Ranges** (work on any comparable type — numbers, dates, date-times,
  strings): `assert_range(lower, upper)` checks that two bounds form a sensible
  range (`lower <= upper`), treating a `NULL` bound as open-ended;
  `assert_between(x, lower, upper)` checks that values fall within bounds, with
  either bound optional.

# assert 0.0.1

First release of **assert**, a lightweight toolkit of readable assertion
helpers for validating function inputs and outputs.

Each assertion checks a single condition, returns its input invisibly so checks
can be stacked, and throws a clear, caller-aware error on failure. Pass
`null_ok = TRUE` to allow optional arguments that default to `NULL`.

## Assertions

* **Scalars** (reject `NA`): `assert_scalar_character()`,
  `assert_scalar_numeric()`, `assert_scalar_integer()`,
  `assert_scalar_double()`, `assert_scalar_logical()`,
  `assert_scalar_complex()`, `assert_scalar_count()`.
* **Vectors and objects**: `assert_character()`, `assert_numeric()`,
  `assert_integer()`, `assert_double()`, `assert_logical()`,
  `assert_complex()`, `assert_list()`, `assert_factor()`,
  `assert_function()`, `assert_class()`, `assert_list_of()`.
* **Length and names**: `assert_length()`, `assert_minimum_length()`,
  `assert_maximum_length()`, `assert_not_empty()`, `assert_named()`,
  `assert_unique_names()`, `assert_has_names()`.
* **Values**: `assert_no_missing_values()`, `assert_no_duplicates()`,
  `assert_all_finite()`, `assert_all_whole_numbers()`,
  `assert_no_empty_strings()`, `assert_all_positive()`,
  `assert_all_non_negative()`, `assert_all_negative()`,
  `assert_all_non_positive()`, `assert_all_within_range()`,
  `assert_values_in_set()`, `assert_matches_pattern()`.
* **Strings**: `assert_minimum_characters()`, `assert_maximum_characters()`.
* **Comparisons and order**: `assert_all_greater_than()`,
  `assert_all_greater_than_or_equal()`, `assert_all_less_than()`,
  `assert_all_less_than_or_equal()`, `assert_sorted()`,
  `assert_same_length()`.
* **Sets**: `assert_set_equal()`, `assert_disjoint()`.
* **Argument groups**: `assert_mutually_exclusive()`,
  `assert_at_least_one()`, `assert_exactly_one()`.
* **Data frames and data tables**: `assert_data_frame()`,
  `assert_data_table()`, `assert_not_empty_data_frame()`,
  `assert_number_of_rows()`, `assert_number_of_columns()`,
  `assert_has_columns()`, `assert_column_names()`,
  `assert_no_missing_in_columns()`, `assert_column_types()`,
  `assert_columns_are_type()`, `assert_unique_rows()`.
* **Conditions**: `assert_true()`, `assert_false()`, `assert_null()`,
  `assert_not_null()`.
