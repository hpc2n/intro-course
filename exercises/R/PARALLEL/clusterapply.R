library(parallel)

# define a function to be applied
square_function <- function(x) {
  return(sqrt(x))
}

# create a list of numbers
numbers <- seq(1,100000)

# Create a cluster with 2 workers
cl <- makeCluster(1)

# Apply the function in parallel using lapply
ptime <- system.time({ result_parallel <- clusterApply(cl, numbers, square_function) })[3]

# Stop the cluster
stopCluster(cl)

# Print the simulation time
print(ptime)
# Print the sum of the results
print(sum(unlist(result_parallel)))

