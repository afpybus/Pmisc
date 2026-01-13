# Create color bar legend

Create color bar legend

## Usage

``` r
color.bar(
  bc,
  min,
  max = -min,
  nticks = 5,
  ticks = seq(min, max, len = nticks),
  title = ""
)
```

## Arguments

- bc:

  Vector of colors

- min:

  Minimum value

- max:

  Maximum value (default: -min)

- nticks:

  Number of ticks (default: 5)

- ticks:

  Tick positions

- title:

  Legend title (default: ”)

## Value

Base plot color bar
