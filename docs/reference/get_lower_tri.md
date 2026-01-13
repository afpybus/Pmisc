# Get lower triangle of matrix

Extract lower triangle, useful for correlation heatmaps

## Usage

``` r
get_lower_tri(mat)
```

## Arguments

- mat:

  Matrix

## Value

Matrix with upper triangle set to NA

## Examples

``` r
m <- matrix(1:9, 3, 3)
get_lower_tri(m) # Returns matrix with upper triangle as NA
#>      [,1] [,2] [,3]
#> [1,]    1   NA   NA
#> [2,]    2    5   NA
#> [3,]    3    6    9
```
