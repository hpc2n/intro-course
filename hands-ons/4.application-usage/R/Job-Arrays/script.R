job_id <- Sys.getenv("SLURM_ARRAY_JOB_ID")
cat(sprintf("This is job ID %s", job_id))
task_id <- Sys.getenv("SLURM_ARRAY_TASK_ID")
cat(sprintf("This is task ID %s", task_id))

Sys.sleep(30)
my_id

