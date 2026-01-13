# Get earliest values from time series

Get earliest values from time series

## Usage

``` r
earliest(dates, values)
```

## Arguments

- dates:

  Vector of dates

- values:

  Corresponding values

## Value

Mean of values at earliest date

## Examples

``` r
earliest(c(1, 2, 2, 3), c(10, 20, 30, 40)) # Returns 10
#> [1] 10
```
