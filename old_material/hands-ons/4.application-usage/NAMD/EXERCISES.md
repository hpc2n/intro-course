# Hands-on exercises. 

---
# Benchmarking a simulation

## 1. MPI 

### 1.1

Go to the MPI/ folder and run the script job-mpi.sh (sbatch job-mpi.sh). Take a look
at the file "output_mpi.dat" and search for the lines starting with "Info: Benchmark", 
they report the performance of NAMD in days/ns. 

### 1.2

Instead of the step4_equilibration.inp input script in job-mpi.sh, use now the script
step4_equilibration_mts.inp which makes use of the multiple time step (MTS) algorithm.
Get the performance as you did previously and compare it with the one you already have.

MTS is one way to speed up the simulations in NAMD.

## 2. GPU

### 2.1

In the GPU/ folder you can find the script job-gpu.sh. Submit this script to the queue
with "sbatch job-gpu.sh" and use the number you get from sbatch (this is called 
job ID) to get an URL on the command line by typing:  

job-usage job_ID

Then, copy and paste that URL on your local browser. After ~1 min. you will start
to see the usage of the resources. Tip: In the top-right corner change the updating
default 15m to 30s. When the script finishes, you should see a plot for
the CPU/GPU usage. 

What is the performance on GPUs w.r.t. the one obtained on CPUs?

### 2.2

What is the percentage of the GPUs used in the simulation based on the results from
job-usage?

