# Matrix Manipulation for Multi-dimensional Linear Algebra
## 2D matrix (Xm,n), m x n, dimension m is row, dimension n is column
## a matrix with one of the dimensions being one -> Xm, 1, m x 1 -> Vector

## Matrix Dimensionality
# Entry selection
using DataSci4Chem
m = 15
n = 21
X = randn(m,n)

x1 = X[5:20]
println(x1)

x1 = X[5,20]
println(x1)

x2 = X[3 : 10, 2]
println(x2)

X1 = X[5:10, 1:3]
println(X1)

X2 = X[:, 2]
println(X2)

X3 = X[3 : 5, :]
println(X3)

X4 = X[:, [1, 3, 21]]
println(X4)

## Matrix operations
### Element-wise vs. Matrix-wise
#### Element-wise
### 2 matrices must have exactly same size for element-wise
A = rand(4, 5)
B = rand(4, 5)
C = A + B  ## or B + A (commutative)
E = (A + B) + C  # or A + (B + C), associative
D = A - B

X4tran = [1 2 ; 4 3 ; 5 4]
println(X4tran)
X_t = transpose(X4tran)  # X^T
println(X_t)

X5 = X4tran .* 2
println(X5)

X6 = X4tran .* (2 * ones(3, 2))  # Hadamard product
println(X6)
# = 2 * X4tran .* ones(3, 2) = 2 * (X4tran .* ones(3, 2)), associative
ones(3,2)

#### Matrix-wise
### 2 matrices must have the same inner dimensions
## Am, p * Bp, n = Cm, n
# Ci, j = Sum( ai,k * bk,j )
# 0 * A = 0,  A * 0 = 0
# I * A = A,  A * I = a
# A(B + C) = AB + AC,  (A + B)C = AC + BC
# (A * B)^T = A^T * B^T

## A^n = Product( A ), only for square matrices due to self-multiplication

## A^-1 * A = I
# if A = [ a b : c d]
# A^-1 = ( 1/ a*c - b*d) * [ d -b : -c a ]
A = [1 2 ; 1 -1]
inv(A)
# (A^-1)^-1 = A
# (A^T)^-1 = (A^-1)^T
# y = Ax -> x = y/A = A^-1 * y

## Matrix decomposition/ factorization into Product Matrices
# LU Decomposition for solving systems of equations
# Singular Value Decomposition (SVD) -> Umxn, Dnxn, Vnxn^T
# Umxn, Left singular matrix, represents a rotation in the matrix space
# Dnxn, Diagonal matrix, contains the singular values
# Vnxn^T, Right singular matrix, is associated with rotation