# Volcano plot with labels for all features

Variant of volcano_cm that labels all points regardless of significance

## Usage

``` r
volcano_cm_labelall(comp_means_output, x = "mean_dif", max_overlaps = 10)
```

## Arguments

- comp_means_output:

  Output from comp_means

- x:

  X-axis variable

- max_overlaps:

  Maximum label overlaps

## Value

ggplot object

## See also

[`volcano_cm`](https://afpybus.github.io/Pmisc/reference/volcano_cm.md)

[`vignette("comp_means")`](https://afpybus.github.io/Pmisc/articles/comp_means.md)
