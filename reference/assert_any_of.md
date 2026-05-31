# Assert that an object satisfies at least one of several checks

The disjunction ("one of") counterpart to stacking assertions, which is
conjunction ("all of"). Runs each assertion in `...` against `x` and
accepts as soon as one succeeds; if every one fails, raises a single
error that lists each alternative's requirement. Use it for a value that
may legitimately be one of several types or shapes — e.g. a numeric *or*
a character vector, or an object of one R6 class *or* another.

## Usage

``` r
assert_any_of(
  x,
  ...,
  null_ok = FALSE,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  Object to check.

- ...:

  One or more assertion functions, each called as `f(x)`. `x` passes if
  any of them accepts it without raising an error.

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

## Details

Each `...` entry is a function taking `x` as its first argument. Pass an
existing assertion by name for a simple type alternative, or a small
closure that stacks several checks for a constrained alternative.

Note: a check function that errors for *any* reason — including a bug in
its own code, not just an assertion failure — counts as that alternative
failing. This is inherent to a try-first combinator, which cannot tell
an assertion failure from an unrelated error. Keep the check functions
to assertions, and if a check is non-trivial, test it on its own.

## Examples

``` r
assert_any_of(42, assert_numeric, assert_character)
assert_any_of("a", assert_numeric, assert_character)

# A constrained alternative is a closure stacking several checks:
assert_any_of(
  3L,
  function(v) {
    assert_scalar_integer(v)
    assert_between(v, 1L, 6L)
  },
  function(v) assert_scalar_character(v)
)
```
