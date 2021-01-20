library("Rmpi")
 
mpi.spawn.Rslaves(nslaves=55)
mpi.bcast.cmd(id <- mpi.comm.rank())
mpi.bcast.cmd(n <- mpi.comm.size())
mpi.bcast.cmd(host <- mpi.get.processor.name())
result <- mpi.remote.exec(paste("Rank of process =", id, "Size of Communicator", n, "Hostname", host))
print(unlist(result))

x <- 48.0
mpi.bcast.cmd(myfunc <- function(x) { y <- x^2 })
result <- mpi.remote.exec(cmd=myfunc, x)
result

mpi.close.Rslaves(dellog = TRUE)
mpi.exit()
