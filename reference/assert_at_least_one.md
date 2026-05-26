# Assert that at least one of several arguments is supplied

Treats a `NULL` argument as "not supplied". Raises an error if every
argument in `...` is `NULL`.

## Usage

``` r
assert_at_least_one(..., call = rlang::caller_env())
```

## Arguments

- ...:

  Two or more arguments to check, typically optional parameters of the
  calling function that default to `NULL`.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

`NULL`, invisibly.

## Examples

``` r
fetch <- function(id = NULL, name = NULL) {
  assert_at_least_one(id, name)
  "ok"
}
fetch(name = "ada")
#> [1] "ok"
```
