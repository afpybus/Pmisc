# Rotate OPLS scores and loadings

Rotate, swap, and flip OPLS-DA results for better visualization

## Usage

``` r
rotate_opls(plsOut, degrees = 0, swap = F, flip_y = F, flip_x = F)
```

## Arguments

- plsOut:

  OPLS model object

- degrees:

  Rotation angle in degrees (default: 0)

- swap:

  Swap axes 1 and 2 (default: FALSE)

- flip_y:

  Flip Y-axis (default: FALSE)

- flip_x:

  Flip X-axis (default: FALSE)

## Value

List with rotated scores, loadings, and rotation matrix
