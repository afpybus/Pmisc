# Correlation heatmap with clustering

Correlation heatmap with clustering

## Usage

``` r
cor_hm(
  mat,
  title = "",
  x.str = "",
  y.str = "",
  color1 = "black",
  color2 = "white",
  color3 = "purple",
  cex_r = 1,
  cex_c = 0.6,
  mar = c(12, 13)
)
```

## Arguments

- mat:

  Data matrix

- title:

  Plot title (default: "")

- x.str:

  X-axis label (default: "")

- y.str:

  Y-axis label (default: "")

- color1:

  Low correlation color (default: "black")

- color2:

  Mid correlation color (default: "white")

- color3:

  High correlation color (default: "purple")

- cex_r:

  Row label size (default: 1)

- cex_c:

  Column label size (default: 0.6)

- mar:

  Margins (default: c(12,13))

## Value

Heatmap plot
