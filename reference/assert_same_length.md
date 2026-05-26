# Assert that objects share the same length

Checks that every object passed in `...` has the same length. Useful
before element-wise operations on parallel vectors or columns.

## Usage

``` r
assert_same_length(..., call = rlang::caller_env())
```

## Arguments

- ...:

  Two or more objects to compare. Their lengths must all be equal.

- call:

  Environment used as the error's call context. Defaults to the calling
  function, so errors point at the user's code.

## Value

The first object in `...`, invisibly.

## Examples

``` r
assert_same_length(c(1, 2, 3), c("a", "b", "c"))
```
