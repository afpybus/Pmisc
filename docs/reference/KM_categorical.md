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

## See also

[`coxph_all`](https://afpybus.github.io/Pmisc/reference/coxph_all.md),
[`gene_OS_scatter`](https://afpybus.github.io/Pmisc/reference/gene_OS_scatter.md)

[`vignette("survival_analysis")`](https://afpybus.github.io/Pmisc/articles/survival_analysis.md)
