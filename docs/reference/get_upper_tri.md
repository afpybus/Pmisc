# Get upper triangle of matrix

Extract upper triangle, useful for correlation heatmaps

## Usage

``` r
get_upper_tri(mat)
```

## Arguments

- mat:

  Matrix

## Value

Matrix with lower triangle set to NA

## Examples

``` r
m <- matrix(1:9, 3, 3)
get_upper_tri(m) # Returns matrix with lower triangle as NA
#>      [,1] [,2] [,3]
#> [1,]    1    4    7
#> [2,]   NA    5    8
#> [3,]   NA   NA    9
```
