# Arrange multiple ggplot objects in a grid

Arrange multiple ggplot objects in a grid

## Usage

``` r
make_grid(
  ggplots_list,
  nrow = floor(sqrt(length(ggplots_list))),
  ncol = ceiling(length(ggplots_list)/nrow)
)
```

## Arguments

- ggplots_list:

  List of ggplot objects

- nrow:

  Number of rows (default: auto-calculated)

- ncol:

  Number of columns (default: auto-calculated)

## Value

Arranged plot grid
