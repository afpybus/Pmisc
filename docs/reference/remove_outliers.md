# Remove outliers based on IQR

Remove points outside of coef\*IQR from Q1/Q3

## Usage

``` r
remove_outliers(df, var, coef = 3)
```

## Arguments

- df:

  Data frame

- var:

  Variable name to check for outliers

- coef:

  Coefficient multiplier for IQR (default: 3)

## Value

Data frame with outliers removed
