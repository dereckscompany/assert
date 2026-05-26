# Assert that an object is not NULL

Assert that an object is not NULL

## Usage

``` r
assert_not_null(x, arg = rlang::caller_arg(x), call = rlang::caller_env())
```

## Arguments

- x:

  Object to check.

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
assert_not_null(42)
```
