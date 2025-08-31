import timeit
import numpy as np

starttime = timeit.default_timer()

print("Reading in matrix A\n")
A = np.load("matrixA.npy")
print(A)

print("\nReading in matrix B\n")
B = np.load("matrixB.npy")
print(B) 

print()
print("Doing matrix-matrix multiplication...")
print()

C = np.matmul(A, B)

print("The product of matrices A and B is:\n", C) 

print("The shape of the resulting matrix is ", C.shape)

print() 

print("Time elapsed for multiplying matrices is ", timeit.default_timer() - starttime)

