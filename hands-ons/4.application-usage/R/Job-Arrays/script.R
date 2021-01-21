my_id <- Sys.getenv("SLURM_ARRAY_TASK_ID")
cat(sprintf("This is my Array ID %s", my_id))

Sys.sleep(30)
my_id

