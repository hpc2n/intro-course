#Complet script can be found at
#https://researchcomputing.princeton.edu/julia
using Distributed

#worker processes
num_cores = parse(Int, ENV["SLURM_CPUS_PER_TASK"])
addprocs(num_cores)

println("Number of cores:", nprocs())
println("Number of workers:", nworkers())

#id for each worker, process id, hostname
for i in workers()
   id, pid, host = fetch(@spawnat i (myid(), getpid(), gethostname()))
   println(id, " ", pid, " ", host)
end

#remove workers
for i in workers()
   rmprocs(i)
end
