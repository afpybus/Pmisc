# Length of unique values

Calculate the number of unique values in a vector

## Usage

``` r
lu(x, na.rm = FALSE)
```

## Arguments

- x:

  A vector

- na.rm:

  Logical, whether to remove NA values before counting (default: FALSE)

## Value

Integer count of unique values

## Examples

``` r
lu(c(1, 1, 2, 3, 3, 3))
#> [1] 3
lu(c("a", NA, "b", "c"), na.rm = TRUE) # Returns 3
#> [1] 3
```
