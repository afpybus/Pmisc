# Create side panel for upset plot

Create side panel for upset plot

## Usage

``` r
upset_side(
  df,
  value = TRUE,
  side = "left",
  add_percent = TRUE,
  expand = 0.2,
  cex.text = 1
)
```

## Arguments

- df:

  Data frame with binary columns

- value:

  Value to consider TRUE (default: TRUE)

- side:

  Panel side: "left" or "right"

- add_percent:

  Show percentages (default: TRUE)

- expand:

  Expansion factor (default: 0.2)

- cex.text:

  Text size multiplier (default: 1)

## Value

ggplot object
