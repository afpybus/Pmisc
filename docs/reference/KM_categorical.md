# Kaplan-Meier plot by gene expression

Kaplan-Meier plot by gene expression

## Usage

``` r
KM_categorical(df, gene, time_scale, reclass = TRUE)
```

## Arguments

- df:

  Data frame with time, status, and gene columns

- gene:

  Gene/feature name

- time_scale:

  Label for time axis

- reclass:

  Whether to split by median (default: TRUE)

## Value

ggsurvfit object
