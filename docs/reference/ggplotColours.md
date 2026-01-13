# Get default ggplot2 colors

Get default ggplot2 colors

## Usage

``` r
ggplotColours(n = 6, h = c(0, 360) + 15)
```

## Arguments

- n:

  Number of colors (default: 6)

- h:

  Hue range (default: c(0, 360) + 15)

## Value

Character vector of hex colors

## Examples

``` r
ggplotColours(3) # Returns 3 hex color codes
#> [1] "#F8766D" "#00BA38" "#619CFF"
# Example output: c("#F8766D", "#00BA38", "#619CFF")
```
