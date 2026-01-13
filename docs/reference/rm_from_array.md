# Remove specified values from array

Tidy-compatible removal for use in piping operations

## Usage

``` r
rm_from_array(array, values_to_remove)
```

## Arguments

- array:

  Input vector

- values_to_remove:

  Values to exclude

## Value

Filtered vector

## Examples

``` r
rm_from_array(1:5, c(2, 4)) # Returns c(1, 3, 5)
#> [1] 1 3 5
```
