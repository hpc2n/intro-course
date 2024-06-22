#Adapted from https://researchcomputing.princeton.edu/julia
using Distributed

#Get the number of cores from slurm
addprocs(parse(Int, ENV["SLURM_CPUS_PER_TASK"]))


#Loop over the workers and get their ids
for i in workers()
   id = fetch(@spawnat i myid())
   println("My ID: ",id)
end

#remove workers
for i in workers()
   rmprocs(i)
end
