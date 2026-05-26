# Assert that columns of a data frame have specific types

Checks that `x` is a data frame containing each named column, and that
each column is of the type given in `types`. Type names are matched as
in [`is.character()`](https://rdrr.io/r/base/character.html),
[`is.numeric()`](https://rdrr.io/r/base/numeric.html),
[`is.integer()`](https://rdrr.io/r/base/integer.html),
[`is.double()`](https://rdrr.io/r/base/double.html),
[`is.logical()`](https://rdrr.io/r/base/logical.html),
[`is.complex()`](https://rdrr.io/r/base/complex.html),
[`is.factor()`](https://rdrr.io/r/base/factor.html), and
[`is.list()`](https://rdrr.io/r/base/list.html); any other name is
matched against the column's class with
[`inherits()`](https://rdrr.io/r/base/class.html) (for example "Date").

## Usage

``` r
assert_column_types(
  x,
  types,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- types:

  A named list or named character vector mapping column names to the
  expected type of each column, for example
  `list(age = "integer", name = "character")`.

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
people <- data.frame(name = "Ada", age = 36L)
assert_column_types(people, list(name = "character", age = "integer"))
```
