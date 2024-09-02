library(parallel)
library(pryr)

prev <- mem_used()
print(paste("Memory initially allocated by R:", prev/1e6, "MB"))

# Define a relatively large dataframe
data_df <- data.frame(
  ID = seq(1, 1e7),
  Value = runif(1e7)
)

# Create a function to be applied to each row (or a subset of rows)
process_function <- function(i, df) {
  # Process the i-th row 
  return(df$Value[i] * 2)
}
prev <- mem_used() - prev
print(paste("Memory after the serial code execution:", prev/1e6, "MB"))

# Use mclapply to process the dataframe in parallel
num_cores <- 4
results <- mclapply(1:nrow(data_df), function(i) process_function(i, data_df), mc.cores = num_cores)
prev <- mem_used() - prev
print(paste("Memory after parallel code execution:", prev/1e6, "MB"))
