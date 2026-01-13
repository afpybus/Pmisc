# Get latest values from time series

Get latest values from time series

## Usage

``` r
latest(dates, values)
```

## Arguments

- dates:

  Vector of dates

- values:

  Corresponding values

## Value

Mean of values at latest date

## Examples

``` r
latest(c(1, 2, 2, 3), c(10, 20, 30, 40)) # Returns 40
#> [1] 40
```
