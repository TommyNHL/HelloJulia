## Matrix decomposition/ factorization into Product Matrices
# LU Decomposition for solving systems of equations
# Singular Value Decomposition (SVD) -> Umxn, Dnxn, Vnxn^T
# Umxn, Left singular matrix, represents a rotation in the matrix space
# Dnxn, Diagonal matrix, contains the singular values
# Vnxn^T, Right singular matrix, is associated with rotation

# Singular Value Decomposition (SVD)
## row vector samples, column vectoe components
## when 2 matrix rows ain't multiples of each other 
### -> [row1 column1] + [row2 column2]
### -> [row1 row2] * [column1 column2]
### is there a mathematical way of estimating how many components there are present in a data matrix?
### can we quantify how well the sum of component products approximates the original data matrix?

# SVD Theorem
## A = Umxn * Dnxn * Vnxn^T
## Umn, same dimensions as A, has columns that are orthonormal vectors
## Dnxn, Diagonal n x n matrix with +ve or zero elements (the singular values), Weights
## Vnn^T, square matrix with rows (columns in Vnn) that are orthonormal vectors
## orthogonal-vector property of columns of Umn = Sum( uij * uik ) = djk
## orthogonal-vector property of rows of V^T = Sum( vij * vik ) = djk
## A = s1 [u11 u21 u31 ... um1] [v11 v12 v13 ... v1n] + s2 [um2] [v2n] + s3 [um3] [v3n] + ... + sn [umn] [vnn]
##   = s1 u1 v1^T + s2 u2 v2^T + s3 u3 V3^T + ... + sn un vn^T (Dyadic summation)

# Matrix approximation
## X' = Sum( sn un vn^T )
## How well? -> Loss
## Math.abs(X - X') = square-root of 
    ## for (int i = 1; i < r; i++) {
      ## for (int j = 1; j < r; j++) {
        ## Math.abs(xij - x'ij)^2
      ## }
    ## }

using DataSci4Chem
A = [ [1,3,0,2] [2,6,0,4,] [3,9,0,6] ]
F = svd(A)
println(F)
println(F.S)  # Snn values

# Image compression
img = testimage("peppers_gray.tif")
T = channelview(img)[1, :, :]
F = svd(T)
r = 5
tapprox = F.U[:, 1:r] * Diagonal(F.S[1:r]) * F.Vt[1:r, :]
Gray.(tapprox)

r = 10
tapprox = F.U[:, 1:r] * Diagonal(F.S[1:r]) * F.Vt[1:r, :]
Gray.(tapprox)