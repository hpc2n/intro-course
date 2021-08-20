# Hands-on exercises. 

---
# Benchmarking a simulation

## 1. MPI 

### 1.1

Go to the MPI/ folder and run the script job-tune-pme.sh by using different values 
of the nr. of MPI ranks (-n ) and the nr. of OpenMP threads (-c ). One needs to
set these values so that "n x c <= 28" (for a singlenode).

Take a look at the "perf.out" file, especially the last line will tell you what flags
you can use for running GROMACS efficiently.

### 1.2

Use the best combination (-n,-c) obtained from the previous analysis and correct the
*FIXME* strings in the script "job-mpi-gromacs.sh" and submit this file to the batch
queue.

More information about what parameters you can tune with tune_pme tool can be found
in: https://manual.gromacs.org/current/onlinehelp/gmx-tune_pme.html

## 2. GPU

### 2.1

In the GPU/ folder, take a look at the script job-gpu-gromacs.sh. At the end of the
script you will find three different ways to run GROMACS, the first one being the
default way, and the other two where PME is offloaded to GPUs. Submit the script to
the queue and use the number you get from sbatch (this is called job ID) to get an
URL on the command line by typing:  

job-usage job_ID

Then, copy and paste that URL on your local browser. After ~1 min. you will start
to see the usage of the resources. Tip: In the top-right corner change the updating
default 15m to 30s. When the script finishes, you should see a step-like plot for
the CPU usage where each step denotes each simulation. Based on these results, what
is the best option (for the current nr. of cores and GPUs) for running GROMACS?
You can check if this analysis agrees with the performance for each run as reported
in the log file measured in ns/day.

What is the percentage of the GPUs used in the simulation based on the results from
job-usage?

### 2.2
How is the performance on GPUs compared to that on CPUs in the previous example?

More information on GROMACS performance:
  https://manual.gromacs.org/2021/user-guide/mdrun-performance.html
