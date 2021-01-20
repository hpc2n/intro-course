library("Rmpi")
print(mpi.universe.size())

mpi.spawn.Rslaves(nslaves=5)

x <- c(10,20,30,40,50)
mpi.apply(x,runif)

# Close down the MPI processes and quit R
mpi.close.Rslaves()
mpi.finalize()
