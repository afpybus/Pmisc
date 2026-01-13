# Run Cox proportional hazards model for multiple features

Run Cox proportional hazards model for multiple features

## Usage

``` r
coxph_all(df, feature.names, time_col = "time", status_col = "status")
```

## Arguments

- df:

  Data frame with time, status, and feature columns

- feature.names:

  Character vector of feature column names

- time_col:

  Name of time column (default: "time")

- status_col:

  Name of status column (default: "status")

## Value

Data frame with hazard ratios and p-values
