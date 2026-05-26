# Assert that exactly one of several arguments is supplied

Treats a `NULL` argument as "not supplied". Raises an error unless
exactly one argument in `...` is non-`NULL`.

## Usage

``` r
assert_exactly_one(..., call = rlang::caller_env())
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
connect <- function(url = NULL, socket = NULL) {
  assert_exactly_one(url, socket)
  "ok"
}
connect(url = "localhost")
#> [1] "ok"
```
