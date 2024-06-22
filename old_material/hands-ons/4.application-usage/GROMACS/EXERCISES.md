# Hands-on exercises. 

---
# BENCHMARKING A SIMULATION

## 1. EXERCISE - GROMACS MPI 

### 1.1

Go to the MPI/ folder and run the script **job-tune-pme.sh** by using different values 
of the nr. of MPI ranks (-n ) and the nr. of OpenMP threads (-c ). One needs to
set these values so that "n x c <= 28" (for a single node).

Take a look at the "perf.out" file, especially the last line will tell you what flags
you can use for running GROMACS efficiently.

What combination of -n, -c gave you the best performance?

More information about what parameters you can tune with tune_pme tool can be found
in: https://manual.gromacs.org/current/onlinehelp/gmx-tune_pme.html

*Comment: be prepared to wait ~25 min. for some jobs.* 

### 1.2

Use the best combination (-n,-c) obtained from the previous analysis and correct the
*FIXME* strings in the script "job-mpi-gromacs.sh" and submit this file to the batch
queue (**sbatch job-mpi-gromacs.sh**). Use the number you get from sbatch (this is 
called job ID) to get an URL on the command line by typing:  

```
job-usage job_ID
```

Then, copy and paste that URL on your local browser. After ~1 min. you will start
to see the usage of the resources. Tip: In the top-right corner change the updating
default 15m to 30s.

In the plot for CPU usage, you can see how efficiently are the requested resources
being used (in percentage). How efficient is your simulation?

## 2. EXERCISE - GROMACS GPU

### 2.1

In the GPU/ folder, take a look at the script **job-gpu-gromacs.sh**. At the end of the
script you will find three different ways to run GROMACS, the first one being the
default way (no Offloading), the second one the MPI version where nonbonded/PME interactions
are offloaded to GPUs, and the third one being the Threaded-MPI version with nonbonded/PME
interactions offloaded to GPUs. Submit the job to the queue and monitor the usage
with the **job-usage** command that was introduced previously.

When the script finishes, you should see a step-like plot for
the CPU/GPU usage where each step denotes each simulation. Based on these results, what
is the best of the three options in the script (for the current nr. of cores and GPUs) for running GROMACS?
You can check if this analysis agrees with the performance for each run as reported
in the log file measured in ns/day.

What is the percentage of the GPUs used in the simulation based on the results from
job-usage?

Do you observe any performance improvement if you run the simulation on the AMD GPU nodes? 

### 2.2

How is the performance on GPUs version compared to that on CPU-only version in the previous examples?

More information on GROMACS performance:
  https://manual.gromacs.org/2021/user-guide/mdrun-performance.html


## 3. EXERCISE - VIRTUAL SITES

One way to speed up the simulations in GROMACS is by using virtual sites where geometric
constructs are used to avoid the use of constraints on bonds and angles. In the folder
VSITES you will find a standard setup "ClassicalSim" and a setup of the same system
but where virtual sites are applied "VirtualSites", submit the batch jobs and compare
the performances. Where do you see a better performance? What is the main source of
performance improvement?
