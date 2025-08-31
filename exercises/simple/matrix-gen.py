import timeit
import numpy as np

starttime = timeit.default_timer()

np.random.seed(1701)

A = np.random.randint(-1000000, 1000000, size=(8192,4096))
B = np.random.randint(-1000000, 1000000, size =(4096,4096))

print("This is matrix A:\n", A)
print("The shape of matrix A is ", A.shape)
print()
print("Writing matrix A to file:\n")
np.save("matrixA.npy", A)

print("This is matrix B:\n", B)
print("The shape of matrix B is ", B.shape)
print()
print("Writing matrix B to file:\n")
np.save("matrixB.npy", B)

print("Time elapsed for generating matrices is ", timeit.default_timer() - starttime)

