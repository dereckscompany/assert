# Assert that a set of columns are all of one type

Checks that `x` is a data frame containing every name in `columns`, and
that all of those columns are of `type`. To validate several types, call
again with a different `type` and column set. Type names are matched as
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
  type,
  columns,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- type:

  Single string naming the type that every listed column must be.

- columns:

  Character vector of column names to check.

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
people <- data.frame(name = "Ada", height = 1.8, weight = 75.0)
assert_column_types(people, "numeric", c("height", "weight"))
```
