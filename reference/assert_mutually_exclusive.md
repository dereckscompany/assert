# Assert that at most one of several arguments is supplied

Treats a `NULL` argument as "not supplied". Raises an error if two or
more of the arguments in `...` are non-`NULL`. Supplying none is
allowed.

## Usage

``` r
assert_mutually_exclusive(..., call = rlang::caller_env())
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
draw <- function(colour = NULL, palette = NULL) {
  assert_mutually_exclusive(colour, palette)
  "ok"
}
draw(colour = "red")
#> [1] "ok"
```
