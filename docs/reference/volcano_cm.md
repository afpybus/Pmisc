# Create volcano plot from comp_means results

Create volcano plot from comp_means results

## Usage

``` r
volcano_cm(comp_means_output, x = "mean_dif", max_overlaps = 10)
```

## Arguments

- comp_means_output:

  Output from comp_means function

- x:

  X-axis variable: "mean_dif" or "log2fc"

- max_overlaps:

  Maximum label overlaps for ggrepel

## Value

ggplot object
