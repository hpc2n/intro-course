# Hands-on exercises. 

---
# BENCHMARKING A SIMULATION

## 1. EXERCISE - LAMMPS MPI 

### 1.1

Go to the MPI/ folder and run the script **job-mpi.sh** by using different values 
of the nr. of MPI ranks (-n 4,8,16,28, ...), do not exceed more than two nodes (56 cores).

Take a look at the file **log.lammps** on the line which says about the *Performance*
measured in nanoseconds per day (ns/day). You can make a table with the ns/day as a
function of the number of MPI ranks (-n) and see where the optimal value of the
simulation is found.

### 1.2

Use the optimal value of the number of MPI ranks (-n) obtained from the previous analysis
and set this value in the script **job-mpi.sh**. Submit this file to the batch
queue (**sbatch job-mpi.sh**). Use the number you get from sbatch (this is 
called job ID) to get an URL on the command line by typing:  

```
job-usage job_ID
```

Then, copy and paste that URL on your local browser. After ~1 min. you will start
to see the usage of the resources. Tip: In the top-right corner change the updating
default 15m to 30s.

In the plot for CPU usage, you can see how efficiently are the requested resources
being used (in percentage). How efficient is your simulation?

### 1.3

There is a combined MPI/OpenMP version of LAMMPS which for the present test case
is slower that the pure MPI version in the above example. The script for running
this version is **job-omp.sh**. Look at the difference between this script and
the one for the MPI only version. 

In the MPI/OpenMP script, you may to set the number of MPI ranks, -n, and the
number of OpenMP threads, -c, so that **nxc <=28 cores** (for a single node). In the
present example you don't need to change this values.

Submit the present MPI/OpenMP script with **sbatch job-omp.sh** and compare
the performance with the previous MPI example by using 28 cores in both cases.

## 2. EXERCISE - LAMMPS GPU

### 2.1

In the GPU/ folder, take a look at the scripts **job-cpu.sh** and **job-gpu.sh**
which are used for running the same Lennard-Jones particles simulation on CPUs and
GPUS, respectively. Take a look at the difference between these two scripts.

Submit the job to the queue and monitor the usage with the **job-usage**
command that was introduced previously and monitor the CPU/GPU usage.

Take a look at the output files **output_cpu.dat** and **output_gpu.dat** for the
CPU and GPU cases, respectively. Specifically, search for the line which says
about the Performance measured in tau/day. Do you see any improvement by using
GPUs?

